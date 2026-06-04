import requests
from flask import Flask, render_template, request, jsonify

app = Flask(__name__, static_folder='../frontend', template_folder='../frontend')

# Adresse des C++-Services (innerhalb von Kubernetes: cpp-service.default.svc.cluster.local)
CPP_SERVICE_URL = "http://cpp-service:8080/quadrat"

@app.route('/')
def index():
    """Liefert die statische HTML-Seite aus dem frontend-Ordner"""
    return app.send_static_file('index.html')

@app.route('/api/quadrat', methods=['GET'])
def api_quadrat():
    """REST-Endpoint: ruft den C++-Service auf und gibt JSON zurück"""
    zahl = request.args.get('zahl')
    if not zahl or not zahl.isdigit():
        return jsonify({'fehler': 'Ungültige Zahl'}), 400

    try:
        # Aufruf des C++-Services
        cpp_response = requests.get(CPP_SERVICE_URL, params={'zahl': zahl}, timeout=2)
        cpp_response.raise_for_status()
        quadrat = int(cpp_response.text)
        return jsonify({'eingabe': int(zahl), 'quadrat': quadrat})
    except Exception as e:
        return jsonify({'fehler': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
