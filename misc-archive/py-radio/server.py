from flask import Flask, jsonify
import subprocess

app = Flask(__name__)

@app.route("/")
def index():
	return "<h1> This is a basic IoT-controlled radio </h1>"

@app.route('/init')
def init():
	subprocess.call(['sh', 'scripts/initialize.sh'])
	resp = {'message' : 'Player initialized with playlist'}
	resp = jsonify(resp)
	return resp

@app.route('/play')
def play():
	subprocess.call(['sh', 'scripts/play.sh'])
	resp = {'message' : 'Playing Music'}
	resp = jsonify(resp)
	return resp

@app.route('/pause')
def pause():
	subprocess.call(['sh', 'scripts/pause.sh'])
	resp = {'message' : 'Pausing music'}
	resp = jsonify(resp)
	return resp

@app.route('/prev')
def prev():
	subprocess.call(['sh', 'scripts/prev.sh'])
	resp = {'message' : 'Playing Previous stream'}
	resp = jsonify(resp)
	return resp

@app.route('/next')
def next():
	subprocess.call(['sh', 'scripts/next.sh'])
	resp = {'message' : 'Playing next stream'}
	resp = jsonify(resp)
	return resp

@app.route('/stop')
def stop():
	subprocess.call(['sh', 'scripts/stop.sh'])
	resp = {'message' : 'Playing stopped'}
	resp = jsonify(resp)
	return resp

@app.route('/playlist')
def playlist():
	output = subprocess.check_output(['mpc','playlist'])
	if output == "":
		resp = {'message' : 'Playlist not loaded'}
	else:
		resp = {'message' : 'Playlist loaded'}
	resp = jsonify(resp)
	return resp

@app.route('/remove')
def remove():
	subprocess.call(['sh', 'scripts/remove.sh'])
	resp = {'message' : 'Playlist removed'}
	resp = jsonify(resp)
	return resp


if __name__ == "__main__":
	app.run(host='0.0.0.0', port=8080, debug=True)
