A tool for graphing UFloatCurve assets with the json output from
[FModel](https://github.com/4sval/FModel).

```sh
git submodule update --init
pip install bioframe matplotlib numpy scipy
python ue_curve_graph.py /path/to/fmodel/assets/asset.json -o graph.png
python ue_curve_graph.py /path/to/fmodel/assets/*.json -o # %.json -> %.png
```

```
usage: ue_curve_graph.py [-h] [-o [OUTPUT]] [--dpi DPI] [--samples SAMPLES]
                         [--x-acos] [--x-asin] [--x-suffix X_SUFFIX]
                         [--x-scale X_SCALE] [--x-min X_MIN] [--x-max X_MAX]
                         [--y-acos] [--y-asin] [--y-suffix Y_SUFFIX]
                         [--y-scale Y_SCALE] [--y-min Y_MIN] [--y-max Y_MAX]
                         [input ...]

Graph a UCurveFloat from an FModel json

positional arguments:
  input

options:
  -h, --help            show this help message and exit
  -o [OUTPUT], --output [OUTPUT]
  --dpi DPI
  --samples SAMPLES
  --x-acos
  --x-asin
  --x-suffix X_SUFFIX
  --x-scale X_SCALE
  --x-min X_MIN
  --x-max X_MAX
  --y-acos
  --y-asin
  --y-suffix Y_SUFFIX
  --y-scale Y_SCALE
  --y-min Y_MIN
  --y-max Y_MAX
```