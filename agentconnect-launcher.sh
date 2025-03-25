#!/bin/bash
DKS_PATH=$FC_ROOT/proconnect-federation/docker/docker-stack

if [ -z "$1" ]; then
    echo "No argument supplied."
    exit 1
# start the default fca stack
elif [ "$1" = 'start' ] || [ "$1" = 's' ];
then
    $DKS_PATH switch bdd-fca-low
    exit 0

# start the default fca stack offline
elif [ "$1" = 'start-offline' ] || [ "$1" = 'so' ];
then
    OFFLINE=1 $DKS_PATH switch bdd-fca-low
    exit 0

# access to the mongo shell
elif [ "$1" = 'mongodb' ] || [ "$1" = 'db' ];
then
    $DKS_PATH mongo-shell-core-fca-low
    exit 0

# delete all previous data in mongo and launch fixtures
elif [ "$1" = 'reset-db' ];
then
    $DKS_PATH reset-db-core-fca-low
    exit 0

# start the default fca stack without pulling docker images
elif [ "$1" = 'start-min' ] || [ "$1" = 'sm' ];
then
    $DKS_PATH switch min-fca-low
    exit 0

# start a min fca low stack without pulling docker images
elif [ "$1" = 'start-min-offline' ] || [ "$1" = 'smo' ];
then
    OFFLINE=1 $DKS_PATH switch min-fca-low
    exit 0

# start the min fca stack without pulling docker images
elif [ "$1" = 'start-min-log' ] || [ "$1" = 'smlo' ];
then
    $DKS_PATH prune && OFFLINE=1 && $DKS_PATH up min-fca-log && $DKS_PATH start-all
    exit 0

# start an hybridge fca stack
elif [ "$1" = 'start-hybridge' ] || [ "$1" = 'sy' ];
then
    $DKS_PATH switch hybridge-fca-low
    exit 0

# start an hybridge fca stack without pulling docker images
elif [ "$1" = 'start-hybridge-offline' ] || [ "$1" = 'syo' ];
then
    $DKS_PATH prune && OFFLINE=1 $DKS_PATH up hybridge-fca-low && $DKS_PATH start-all
    exit 0

# start a default fca stack without idp by default
elif [ "$1" = 'start-rie' ] || [ "$1" = 'rie' ];
then
    $DKS_PATH swtich  min-fca-rie
    exit 0

# start a default fca stack without idp by default
elif [ "$1" = 'start-rie-offline' ] || [ "$1" = 'rieo' ];
then
    $DKS_PATH prune && OFFLINE=1 $DKS_PATH up  min-fca-rie && $DKS_PATH start-all
    exit 0

# restart
elif [ "$1" = 'restart' ] || [ "$1" = 'r' ];
then
    $DKS_PATH start-all
    exit 0

## stop all containers
elif [ "$1" = 'stop' ] || [ "$1" = 'halt' ];
then
    $DKS_PATH halt
    exit 0

# display logs for default fca stack
elif [ "$1" = 'log' ] || [ "$1" = 'l' ];
then
    $DKS_PATH log core-fca-low
    exit 0

# display logs for rie fca stack
elif [ "$1" = 'log-rie' ] || [ "$1" = 'lrie' ];
then
    $DKS_PATH log core-fca-rie
    exit 0

# start a shell in the default fca stack container
elif [ "$1" = 'bash' ] || [ "$1" = 'b' ];
then
    $DKS_PATH shell core-fca-low bash
    exit 0

# clean the code of /back by launching prettier and eslint
elif [ "$1" = 'prepare' ] || [ "$1" = 'p' ];
then
    cd $FC_ROOT/proconnect-federation/back && yarn lint --fix && yarn prettier --write &&\
	cd $FC_ROOT/proconnect-federation/quality/fca && yarn lint --fix && yarn prettier --write
    exit 0

# update the doc
elif [ "$1" = 'doc' ];
then
    $DKS_PATH exec core-fca-low yarn doc
    exit 0


# launch the unit tests with the coverage
elif [ "$1" = 'test-coverage' ] || [ "$1" = 'tc' ];
then
    $DKS_PATH exec core-fca-low yarn test --coverage
    exit 0

# launch the unit tests
elif [ "$1" = 'test' ] || [ "$1" = 't' ];
then
    $DKS_PATH exec core-fca-low yarn test
    exit 0

# launch the cypress tests with the graphic user interface
elif [ "$1" = 'quality' ] || [ "$1" = 'tq' ];
then
    cd $FC_ROOT/proconnect-federation/quality/fca && yarn install && yarn start:low
    exit 0

# launch the cypress tests in headless mode
elif [ "$1" = 'quality-hide' ] || [ "$1" = 'tqh' ];
then
    cd $FC_ROOT/proconnect-federation/quality/fca && yarn install && yarn test:low
    exit 0

# launch the cypress tests on the integration environment
elif [ "$1" = 'quality-integration' ] || [ "$1" = 'tqi' ];
then
    cd $FC_ROOT/proconnect-federation/quality/fca && yarn install && CYPRESS_TEST_ENV=integ01 yarn start:low
    exit 0

# launch the cypress visual tests
elif [ "$1" = 'visual' ] || [ "$1" = 'v' ];
then
    cd $FC_ROOT/proconnect-federation/quality/fca && yarn install && yarn test:low:snapshot
    exit 0

# update the snapshot of the visual tests
elif [ "$1" = 'update-visual' ];
then
    cd $FC_ROOT/proconnect-federation/quality/fca && yarn install && yarn test:low:snapshot --env updateSnapshots=true
    exit 0

## FC Exploitation

# start the exploitation stack
elif [ "$1" = 'start-exploitation' ] || [ "$1" = 'se' ];
then
    $DKS_PATH start exploitation-fca-low
    exit 0

# display log of the exploitation container
elif [ "$1" = 'log-exploitation' ] || [ "$1" = 'le' ];
then
    $DKS_PATH log exploitation-fca-low
    exit 0

# launch the tests for exploitation
elif [ "$1" = 'test-exploitation' ] || [ "$1" = 'te' ];
then
    $DKS_PATH exec exploitation-fca-low yarn test	
    exit 0

# launch the cypress tests for exploitation
elif [ "$1" = 'test-exploitation' ] || [ "$1" = 'tqe' ];
then
   cd $FC_ROOT/proconnect-federation/docker/volumes/src/proconnect-exploitation/fc-exploitation && yarn test:e2e:open
    exit 0

elif [ "$1" = 'test-exploitation' ] || [ "$1" = 'tqeh' ];
then
   cd $FC_ROOT/proconnect-federation/docker/volumes/src/proconnect-exploitation/fc-exploitation && yarn test:e2e
    exit 0

else
    echo "Argument supplied \"$1\" is not implemented."
    exit 0
fi
