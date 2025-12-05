#!/bin/bash

# Usage: wait_for_salt.sh [max_retries]
MAX_RETRIES="${1:-50}"  # Default: 50 retries x 10 seconds = 500 seconds
INTERVAL=10

echo "Waiting for cloud-init to finish VM setup"
echo "Checking every $INTERVAL seconds, up to $MAX_RETRIES times"

if [ -x /usr/bin/cloud-init ]; then
    # Wait for cloud-init to finish
    NEXT_TRY=0
    until [ $NEXT_TRY -eq $MAX_RETRIES ] || ! cloud-init status | grep running
    do
            echo "cloud-init is still running. Retrying... [$NEXT_TRY]";
            sleep $INTERVAL;
            ((NEXT_TRY++));
    done

    if [ $NEXT_TRY -eq $MAX_RETRIES ]
    then
            echo "ERROR: cloud-init is still running after $MAX_RETRIES retries";
            exit 1;
    fi
fi

if [ -x /usr/bin/venv-salt-call ]; then
    echo "Salt Bundle detected! We use it for running sumaform deployment"
    echo "Copying /tmp/grains to /etc/venv-salt-minion/grains"
    cp /tmp/grains /etc/venv-salt-minion/grains
    SALT_CALL=venv-salt-call
elif [ -x /usr/bin/salt-call ]; then
    echo "Classic Salt detected! We use it for running sumaform deployment"
    echo "Copying /tmp/grains to /etc/salt/grains"
    cp /tmp/grains /etc/salt/grains
    SALT_CALL=salt-call
else
    echo "Error: Cannot find venv-salt-call or salt-call on the system"
    exit 1
fi

for i in {0..100}
do
  if ${SALT_CALL} --help &>/dev/null; then
    break
  fi
  echo "Waiting for salt to be installed..."
  sleep 3
done
