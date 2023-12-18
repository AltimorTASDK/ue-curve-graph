if [[ $TOPAZ == "" ]]; then
        echo 'Set $TOPAZ to the Topaz directory in FModel output.' >&2
        exit 1
fi
curve_dir="$TOPAZ/Content/Common/Curves/PlayerMovement"
python ue_curve_graph.py "$curve_dir/GroundMovementAcceleration.json" --x-suffix=" cm/s" --y-min=0 --y-suffix=" cm/s²" -o
python ue_curve_graph.py "$curve_dir/JetpackVerticalAccelerationMultiplier.json" --x-suffix=" cm/s" --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%" -o
python ue_curve_graph.py "$curve_dir/JumpZSpeedLimit.json" --x-suffix=" cm/s" --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%" -o
python ue_curve_graph.py "$curve_dir/OvershootBrakingDeceleration.json" --x-suffix=" cm/s" --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%" -o
python ue_curve_graph.py "$curve_dir/OvershootGroundFriction.json" --x-suffix=" cm/s" --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%" -o
python ue_curve_graph.py "$curve_dir/OvershootGroundMovementAcceleration.json" --x-suffix=" cm/s" --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%" -o
python ue_curve_graph.py "$curve_dir/SkiGravityInfluence.json" --x-suffix=" cm/s" --y-min=0 --y-scale=100 --y-suffix="%" -o
python ue_curve_graph.py "$curve_dir/SkiOnLandVelocityLoss.json" --x-asin --x-suffix="°" --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%" -o
python ue_curve_graph.py "$curve_dir/SkiSteeringInfluence.json" --x-suffix=" cm/s" --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%" -o
python ue_curve_graph.py "$curve_dir/SkiUphillFrictionAmount.json" --x-acos --x-suffix="°" --y-min=0 -o
python ue_curve_graph.py "$curve_dir/SkiOnLandVelocityLoss.json" --x-asin --x-suffix="°" --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%" -o
python ue_curve_graph.py "$curve_dir/StallZFallingGravityInfluence.json" --x-scale=100 --x-suffix="%" --y-min=0 --y-scale=100 --y-suffix="%" -o
python ue_curve_graph.py "$curve_dir/StallZJetpackGravityInfluence.json" --x-suffix=" cm/s" --y-min=0 --y-scale=100 --y-suffix="%" -o