#!/bin/bash

cd content
tar -cf ../payload/content.tar ./*
cd ..

cd payload
tar -cf ../payload.tar ./*
cd ..

if [ -e "payload.tar" ]; then
    gzip payload.tar

    if [ -e "payload.tar.gz" ]; then
        cat decompresser payload.tar.gz > setup.sh
    else
        echo "cannot create payload.tar.gz"
        exit 1
    fi
else
    echo "cannot create payload.tar"
    exit 1
fi

if [ -e "setup.sh" ]; then
    chmod +x "setup.sh"
    echo "setup.sh created"
else
    echo "cannot create setup.sh"
    exit 1
fi

exit 0

