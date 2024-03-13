if [[ $TOPAZ == "" ]]; then
        echo 'Set $TOPAZ to the Topaz directory in FModel output.' >&2
        exit 1
fi

curve_dir="$TOPAZ/Content/Common/Curves/PlayerMovement"

python ue_curve_graph.py "$curve_dir/FallingAccelerationDamping.json"                  -o                        --x-suffix=" cm/s" --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%"
python ue_curve_graph.py "$curve_dir/GroundMovementAcceleration.json"                  -o                        --x-suffix=" cm/s" --y-min=0                           --y-suffix=" cm/s²"
python ue_curve_graph.py "$curve_dir/JetpackingAccelerationDamping.json"               -o                        --x-suffix=" cm/s" --y-min=0             --y-scale=100 --y-suffix="%"
#python ue_curve_graph.py "$curve_dir/JetpackVerticalAccelerationMultiplier.json"       -o                        --x-suffix=" cm/s" --y-min=0             --y-scale=100 --y-suffix="%"
python ue_curve_graph.py "$curve_dir/JetpackVerticalAccelerationMultiplierLight.json"  -o                        --x-suffix=" cm/s" --y-min=0 --y-max=125 --y-scale=100 --y-suffix="%"
python ue_curve_graph.py "$curve_dir/JetpackVerticalAccelerationMultiplierMedium.json" -o                        --x-suffix=" cm/s" --y-min=0 --y-max=125 --y-scale=100 --y-suffix="%"
python ue_curve_graph.py "$curve_dir/JetpackVerticalAccelerationMultiplierHeavy.json"  -o                        --x-suffix=" cm/s" --y-min=0 --y-max=125 --y-scale=100 --y-suffix="%"
python ue_curve_graph.py "$curve_dir/JumpZSpeedLimit.json"                             -o                        --x-suffix=" cm/s" --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%"
python ue_curve_graph.py "$curve_dir/OvershootBrakingDeceleration.json"                -o                        --x-suffix=" cm/s" --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%"
python ue_curve_graph.py "$curve_dir/OvershootGroundFriction.json"                     -o                        --x-suffix=" cm/s" --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%"
python ue_curve_graph.py "$curve_dir/OvershootGroundMovementAcceleration.json"         -o                        --x-suffix=" cm/s" --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%"
python ue_curve_graph.py "$curve_dir/SkiGravityInfluence.json"                         -o                        --x-suffix=" cm/s" --y-min=0             --y-scale=100 --y-suffix="%"
python ue_curve_graph.py "$curve_dir/SkiOnLandVelocityLoss.json"                       -o --x-asin               --x-suffix="°"     --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%"
#python ue_curve_graph.py "$curve_dir/SkiSteeringInfluence.json"                        -o                        --x-suffix=" cm/s" --y-min=0 --y-max=200 --y-scale=100 --y-suffix="%"
python ue_curve_graph.py "$curve_dir/SkiSteeringInfluenceLight.json"                   -o           --x-max=6500 --x-suffix=" cm/s" --y-min=0 --y-max=200 --y-scale=100 --y-suffix="%"
python ue_curve_graph.py "$curve_dir/SkiSteeringInfluenceMedium.json"                  -o           --x-max=6500 --x-suffix=" cm/s" --y-min=0 --y-max=200 --y-scale=100 --y-suffix="%"
python ue_curve_graph.py "$curve_dir/SkiSteeringInfluenceHeavy.json"                   -o           --x-max=6500 --x-suffix=" cm/s" --y-min=0 --y-max=200 --y-scale=100 --y-suffix="%"
python ue_curve_graph.py "$curve_dir/SkiUphillFrictionAmount.json"                     -o --x-acos               --x-suffix="°"     --y-min=0
python ue_curve_graph.py "$curve_dir/SkiOnLandVelocityLoss.json"                       -o --x-asin               --x-suffix="°"     --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%"
#python ue_curve_graph.py "$curve_dir/SkiOnLandVelocityLoss_LightFooted.json"           -o --x-asin               --x-suffix="°"     --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%"
python ue_curve_graph.py "$curve_dir/StallZFallingGravityInfluence.json"               -o          --x-scale=100 --x-suffix="%"     --y-min=0             --y-scale=100 --y-suffix="%"
python ue_curve_graph.py "$curve_dir/StallZJetpackGravityInfluence.json"               -o                        --x-suffix=" cm/s" --y-min=0             --y-scale=100 --y-suffix="%"