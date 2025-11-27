from flask import Flask, request, send_from_directory, jsonify
from werkzeug.utils import secure_filename
from PIL import Image
from rembg import remove
from colorthief import ColorThief
import os

app = Flask(__name__)

UPLOAD_FOLDER = 'uploads'
OUTPUT_FOLDER = 'results'
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)
if not os.path.exists(OUTPUT_FOLDER):
    os.makedirs(OUTPUT_FOLDER)

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['OUTPUT_FOLDER'] = OUTPUT_FOLDER

def remove_background_with_rembg(input_image_path, output_image_path):
    img = Image.open(input_image_path)
    output_image = remove(img)
    output_image.save(output_image_path)
    os.remove(input_image_path)
    return output_image_path

def get_dominant_color(image_path):
    color_thief = ColorThief(image_path)
    dominant_color = color_thief.get_color(quality=1)
    return f'{dominant_color[0]}, {dominant_color[1]}, {dominant_color[2]}'

@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'})
    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'No selected file'})
    filename = secure_filename(file.filename)
    input_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    file.save(input_path)

    output_filename = filename.rsplit('.', 1)[0] + '_processed.png'
    output_path = os.path.join(app.config['OUTPUT_FOLDER'], output_filename)
    processed_image_path = remove_background_with_rembg(input_path, output_path)
    rgb_text = get_dominant_color(processed_image_path)

    return jsonify({'result_image_url': f'http://10.0.2.2:5000/results/{output_filename}', 'rgb_text': rgb_text})

@app.route('/results/<filename>')
def result(filename):
    return send_from_directory(app.config['OUTPUT_FOLDER'], filename)

@app.route('/')
def index():
    return "Enhanced Image Background Removal API"

if __name__ == '__main__':
    app.run(debug=True, port=5000)