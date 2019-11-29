from flask import Flask, request, jsonify
from gevent.pywsgi import WSGIServer

import argparse
import json

def parse_args():
  parser = argparse.ArgumentParser()
  parser.add_argument('--models', '-m', required=True, action='store',
      nargs="*", type=str, help='Models to use, there will be one route for'
      'each model')
  return parser.parse_args()

if __name__ == '__main__':
  flags = parse_args()
  print(f'{flags}')
