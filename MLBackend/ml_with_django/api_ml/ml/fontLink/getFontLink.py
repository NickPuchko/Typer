def get_link(data, title):
    for font in data['items']:
        if font['family'] == title:
            return font['files']['regular']
