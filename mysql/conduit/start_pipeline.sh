#!/bin/bash

set -euo pipefail

curl -X POST localhost:8081/v1/pipelines/mysql-to-kafka/start