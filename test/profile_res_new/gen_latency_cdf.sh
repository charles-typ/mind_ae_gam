for system in "s3" "dynamodb" "crail" "redis" "mmux"; do
    for op in "read" "write"; do
        f="../data/${system}_${op}_latency.txt"
        python find_cdf.py $f
    done
done
