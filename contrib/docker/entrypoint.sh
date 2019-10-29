#!/bin/sh

if [ ! -f /config/ot-recorder ]; then
    cp -f /config/ot-recorder.conf.default /config/ot-recorder
fi

ot-recorder --initialize
ot-recorder --doc-root /htdocs
