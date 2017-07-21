#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Copyright 2017 Itamar Ostricher

from sanic import Sanic
from sanic.response import json, raw


app = Sanic()


@app.route('/<uri:.*>', methods=['GET', 'POST'])
async def echo(request, uri):
    return raw(request.body)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
