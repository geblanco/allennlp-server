from allennlp.predictors.predictor import Predictor

from flask import Flask, request, jsonify
from gevent.pywsgi import WSGIServer

import argparse
import json

def parse_args():
  parser = argparse.ArgumentParser()
  parser.add_argument('--port', '-p', required=False, type=int, default=8000,
      help='Port to serve')
  parser.add_argument('--models', '-m', required=True, action='store',
      nargs="*", type=str, help='Models to use, there will be one route for'
      'each model')
  parser.add_argument('--routes', '-r', required=True, action='store',
      nargs="*", type=str, help='Routes to serve the models, there should be'
      'one route for each model')
  return parser.parse_args()

def setup_route(route, model):
  allennlp_model = Predictor.from_path(model)

  @app.route(f'/{route}', methods=['POST'])
  def serve_route():
    data = request.get_json()
    if data is None:
      return jsonify({})
    text = data.get('text', None)
    if text is None:
      return jsonify({})
    return jsonify({'results': allennlp_model.predict(sentence=text)})

def serve(full_models, port):
  app = Flask(__name__)
  for (route, model) in full_models:
    setup_route(route, model)

  # serve on all interfaces with ip on given port
  http_server = WSGIServer(('0.0.0.0', port), app)
  print(f'Requester serving on port {port}')
  http_server.serve_forever()

if __name__ == '__main__':
  flags = parse_args()
  if len(flags.routes) != len(flags.models):
    raise ValueError('You must provide one route for each model, got: ', flags)
  full_models = list(zip(flags.routes, flags.models))
  serve(full_models, flags.port)
  print(f'{flags}')
