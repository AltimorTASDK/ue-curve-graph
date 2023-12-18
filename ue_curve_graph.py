import argparse
import json
import math
import matplotlib.pyplot as plt
import sys
from adjustText.adjustText import adjust_text
from decimal import Decimal
from itertools import pairwise
from numpy import float32
from typing import Literal

DEFAULT_OUTPUT = object()

parser = argparse.ArgumentParser(
    description="Graph a UCurveFloat from an FModel json")

parser.add_argument("input",
                    nargs='*',
                    type=argparse.FileType("r"),
                    default=sys.stdin)

parser.add_argument("-o", "--output",
                    nargs='?',
                    type=argparse.FileType("wb"),
                    const=DEFAULT_OUTPUT)

parser.add_argument("--dpi",      type=float,
                                  default=200)
parser.add_argument("--samples",  type=int,
                                  default=1000)

parser.add_argument("--x-acos",   action='store_true')
parser.add_argument("--x-asin",   action='store_true')
parser.add_argument("--x-suffix", type=str)
parser.add_argument("--x-scale",  type=float)
parser.add_argument("--x-min",    type=float)
parser.add_argument("--x-max",    type=float)

parser.add_argument("--y-acos",   action='store_true')
parser.add_argument("--y-asin",   action='store_true')
parser.add_argument("--y-suffix", type=str)
parser.add_argument("--y-scale",  type=float)
parser.add_argument("--y-min",    type=float)
parser.add_argument("--y-max",    type=float)

args = parser.parse_args()

ONE_THIRD = float32(1 / 3)

class CurveKey:
    Time: float32
    Value: float32
    InterpMode: Literal['RCIM_Constant', 'RCIM_Linear', 'RCIM_Cubic']
    ArriveTangent: float32
    LeaveTangent: float32

def lerp(a: float, b: float, t: float) -> float:
    return a + (b - a) * t

def bezier(*points: float, t: float) -> float:
    while len(points) > 1:
        points = [lerp(*pair, t) for pair in pairwise(points)]
    return points[0]

def eval_curve(curve: list[CurveKey], time: float) -> float:
    time = float32(time)

    if time <= curve[0].Time:
        return curve[0].Value

    if time >= curve[-1].Time:
        return curve[-1].Value

    key1, key2 = next((a, b) for a, b in pairwise(curve) if b.Time > time)
    delta = key2.Time - key1.Time
    alpha = (time - key1.Time) / delta

    match key1.InterpMode:
        case 'RCIM_Constant':
            return key1.Value
        case 'RCIM_Linear':
            return lerp(key1.Value, key2.Value, alpha)
        case 'RCIM_Cubic':
            return bezier(key1.Value,
                          key1.Value + key1.LeaveTangent  * delta * ONE_THIRD,
                          key2.Value - key2.ArriveTangent * delta * ONE_THIRD,
                          key2.Value,
                          t=alpha)

def round_f32(value: float, max_precision: int=10) -> Decimal:
    exact = round(Decimal(float(value)), max_precision)
    for precision in range(1, max_precision):
        rounded = round(exact, precision)
        if float32(exact) == float32(rounded):
            return +rounded
    return +exact

def graph_curve(curve: list[CurveKey]):
    def translate_x(x: float) -> float:
        if args.x_acos: x = math.acos(x) * 180 / math.pi
        if args.x_asin: x = math.asin(x) * 180 / math.pi
        if args.x_scale is not None: x *= args.x_scale
        return x

    def translate_y(y: float) -> float:
        if args.y_acos: y = math.acos(y) * 180 / math.pi
        if args.y_asin: y = math.asin(y) * 180 / math.pi
        if args.y_scale is not None: y *= args.y_scale
        return y

    def apply_axis_limits(graph_x: list[float], graph_y: list[float]):
        min_x = min(graph_x) if args.x_min is None else args.x_min
        max_x = max(graph_x) if args.x_max is None else args.x_max
        min_y = min(graph_y) if args.y_min is None else args.y_min
        max_y = max(graph_y) if args.y_max is None else args.y_max
        margin_x, margin_y = plt.gca().margins()
        margin_x *= max_x - min_x
        margin_y *= max_y - min_y
        plt.ylim(min_y - margin_y, max_y + margin_y)

    min_x = curve[0].Time
    max_x = curve[-1].Time
    count = args.samples - len(curve) + 1
    samples_x = [lerp(min_x, max_x, n / count) for n in range(1, count)]
    samples_x = sorted(samples_x + [key.Time for key in curve])
    samples_y = [eval_curve(curve, x) for x in samples_x]
    graph_x = [*map(translate_x, samples_x)]
    graph_y = [*map(translate_y, samples_y)]
    apply_axis_limits(graph_x, graph_y)
    plt.plot(graph_x, graph_y, color='tomato')

    points = [(translate_x(key.Time), translate_y(key.Value)) for key in curve]
    for x, y in points:
        plt.plot(x, y, "o", color='tomato')

    points_x = [x for x, y in points]
    points_y = [y for x, y in points]
    is_x_axis_ints = all(round(x, 4) == round(x) for x in points_x)
    is_y_axis_ints = all(round(y, 4) == round(y) for y in points_y)
    min_y, max_y = plt.ylim()
    text_offset = (max_y - min_y) * 0.05

    def format_xy(x: float, y: float) -> str:
        text_x = f"{x:z.0f}" if is_x_axis_ints else str(round_f32(x, 4))
        text_y = f"{y:z.0f}" if is_y_axis_ints else str(round_f32(y, 4))
        if args.x_suffix: text_x += args.x_suffix
        if args.y_suffix: text_y += args.y_suffix
        return f"({text_x}, {text_y})"

    adjust_text([plt.text(x, y + text_offset, format_xy(x, y), size='x-small')
                 for x, y in points])

def save_figure(in_file):
    if args.output is DEFAULT_OUTPUT:
        if in_file.name.endswith(".json"):
            out_file = f"{in_file.name[:-5]}.png"
        else:
            out_file = f"{in_file.name}.png"
    else:
        out_file = args.output

    plt.savefig(out_file, dpi=args.dpi)

def main():
    class JsonHook(dict):
        def __getitem__(self, key):
            match super().__getitem__(key):
                case float(f): return float32(f)
                case value:    return value
        def __getattr__(self, name):
            return self[name]

    for in_file in args.input:
        data = json.load(in_file, object_hook=JsonHook)

        if not hasattr(data, '__len__') or len(data) != 1:
            raise ValueError("Expected a single-element array as json root.")
        if any(attr not in data[0] for attr in ['Name', 'Properties']):
            raise ValueError("Not a recognized FModel json.")
        if 'FloatCurve' not in data[0].Properties:
            raise ValueError("Not a UCurveFloat.")

        plt.clf()
        plt.style.use('dark_background')
        plt.title(data[0].Name)
        graph_curve(data[0].Properties.FloatCurve.Keys)

        if args.output is None:
            plt.show()
        else:
            save_figure(in_file)

if __name__ == "__main__":
    main()