from flask import Flask, request, send_from_directory, jsonify
from werkzeug.utils import secure_filename
from PIL import Image
from rembg import remove
from colorthief import ColorThief
import os

PALETTES = {
    "Pale Aqua": ["#D9ED92", "#B5E7A0", "#95D9C3", "#85D6E0", "#84BAE8"],
    "NONAME": ["#1E252A", "#63798B", "#999C07", "#CAE3E2", "#EBE5DE"]
}

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

def rgb_to_hex(rgb_text):
    rgb_list = [int(x) for x in rgb_text.split(', ')]
    hex_code = ''.join([f'{color:02X}' for color in rgb_list])
    return f'#{hex_code}'

def get_matching_palette(hex_color):
    for palette_name, palette_colors in PALETTES.items():
        if hex_color in palette_colors:
            return palette_colors
    return "No matching palette found"

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
    rgb_hex = rgb_to_hex(rgb_text)
    matching_palette = get_matching_palette(rgb_hex)

    return jsonify({'result_image_url': f'http://10.0.2.2:5000/results/{output_filename}', 'rgb_text': rgb_text, 'hex': rgb_hex, 'matching_palette': matching_palette})

@app.route('/results/<filename>')
def result(filename):
    return send_from_directory(app.config['OUTPUT_FOLDER'], filename)

@app.route('/')
def index():
    return "Enhanced Image Background Removal API"

if __name__ == '__main__':
    app.run(debug=True, port=5000, threaded=True)