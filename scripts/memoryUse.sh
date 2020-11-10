#!/bin/bash


COM=$(free | awk '/Mem/{print $3/1000}' })


