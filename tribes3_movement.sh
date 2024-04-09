if [[ $TOPAZ == "" ]]; then
        echo 'Set $TOPAZ to the Topaz directory in FModel output.' >&2
        exit 1
fi

IFS=$'\0'

curve_dir="$TOPAZ/Content/Common/Curves/PlayerMovement"
extra_dir="$curve_dir/Extras"
mkdir -p "$extra_dir"

graph_curve()
{
    python ue_curve_graph.py "$curve_dir/$1.json" -o ${@:2} &
}

graph_extra()
{
    python ue_curve_graph.py "$curve_dir/$1.json" -o "$extra_dir/$1_$2.png" ${@:3} &
}

graph_curve "FallingAccelerationDamping"                                             --x-suffix=" cm/s" --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%"
graph_curve "GroundMovementAcceleration"                                             --x-suffix=" cm/s" --y-min=0                           --y-suffix=" cm/s²"
graph_curve "JetpackingAccelerationDamping"                                          --x-suffix=" cm/s" --y-min=0             --y-scale=100 --y-suffix="%"
graph_curve "JetpackVerticalAccelerationMultiplierLight"                --x-max=4200 --x-suffix=" cm/s" --y-min=0 --y-max=130 --y-scale=100 --y-suffix="%"
graph_curve "JetpackVerticalAccelerationMultiplierMedium"               --x-max=4200 --x-suffix=" cm/s" --y-min=0 --y-max=130 --y-scale=100 --y-suffix="%"
graph_curve "JetpackVerticalAccelerationMultiplierHeavy"                --x-max=4200 --x-suffix=" cm/s" --y-min=0 --y-max=130 --y-scale=100 --y-suffix="%"
graph_curve "JumpZSpeedLimit"                                                        --x-suffix=" cm/s" --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%"
graph_curve "OvershootBrakingDeceleration"                                           --x-suffix=" cm/s" --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%"
graph_curve "OvershootGroundFriction"                                                --x-suffix=" cm/s" --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%"
graph_curve "OvershootGroundMovementAcceleration"                                    --x-suffix=" cm/s" --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%"
graph_curve "SkiGravityInfluence"                                                    --x-suffix=" cm/s" --y-min=0             --y-scale=100 --y-suffix="%"
graph_curve "SkiOnLandVelocityLoss"                       --x-asin                   --x-suffix="°"     --y-min=0 --y-max=100 --y-scale=100 --y-suffix="%"
graph_curve "SkiSteeringInfluenceLight"                                 --x-max=6500 --x-suffix=" cm/s" --y-min=0 --y-max=200 --y-scale=100 --y-suffix="%"
graph_curve "SkiSteeringInfluenceMedium"                                --x-max=6500 --x-suffix=" cm/s" --y-min=0 --y-max=200 --y-scale=100 --y-suffix="%"
graph_curve "SkiSteeringInfluenceHeavy"                                 --x-max=6500 --x-suffix=" cm/s" --y-min=0 --y-max=200 --y-scale=100 --y-suffix="%"
graph_curve "SkiUphillFrictionAmount"                     --x-acos                   --x-suffix="°"     --y-min=0
graph_curve "StallZFallingGravityInfluence"               --x-scale=100              --x-suffix="%"     --y-min=0             --y-scale=100 --y-suffix="%"
graph_curve "StallZJetpackGravityInfluence"                                          --x-suffix=" cm/s" --y-min=0             --y-scale=100 --y-suffix="%"

graph_extra "JetpackVerticalAccelerationMultiplierLight"  "Accel"                    --y-scale=1475 --y-min=0       --y-max=1843.75 --y-suffix="cm/s^2" --x-suffix=" cm/s" --x-max=4200
graph_extra "JetpackVerticalAccelerationMultiplierMedium" "Accel"                    --y-scale=1400 --y-min=0       --y-max=1843.75 --y-suffix="cm/s^2" --x-suffix=" cm/s" --x-max=4200
graph_extra "JetpackVerticalAccelerationMultiplierHeavy"  "Accel"                    --y-scale=1325 --y-min=0       --y-max=1843.75 --y-suffix="cm/s^2" --x-suffix=" cm/s" --x-max=4200
graph_extra "JetpackVerticalAccelerationMultiplierLight"  "NetAccel" --y-add=-1494.5 --y-scale=1475 --y-min=-683.25 --y-max=349.25  --y-suffix="cm/s^2" --x-suffix=" cm/s" --x-max=4200
graph_extra "JetpackVerticalAccelerationMultiplierMedium" "NetAccel" --y-add=-1494.5 --y-scale=1400 --y-min=-683.25 --y-max=349.25  --y-suffix="cm/s^2" --x-suffix=" cm/s" --x-max=4200
graph_extra "JetpackVerticalAccelerationMultiplierHeavy"  "NetAccel" --y-add=-1494.5 --y-scale=1325 --y-min=-683.25 --y-max=349.25  --y-suffix="cm/s^2" --x-suffix=" cm/s" --x-max=4200

wait