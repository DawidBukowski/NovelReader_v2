import onnx

MODEL_PATH = "en_US-amy-medium.onnx"
SAMPLE_RATE = "22050"
N_SPEAKERS = "1"
LANGUAGE = "en"
COMMENT = "patched metadata"

m = onnx.load(MODEL_PATH)

# Remove any existing keys we set
keep = [p for p in m.metadata_props if p.key not in ("sample_rate", "n_speakers", "language", "comment")]
del m.metadata_props[:]
for p in keep:
    prop = m.metadata_props.add()
    prop.key = p.key
    prop.value = p.value

# Add required keys
prop = m.metadata_props.add(); prop.key = "sample_rate"; prop.value = SAMPLE_RATE
prop = m.metadata_props.add(); prop.key = "n_speakers"; prop.value = N_SPEAKERS
prop = m.metadata_props.add(); prop.key = "language"; prop.value = LANGUAGE
prop = m.metadata_props.add(); prop.key = "comment"; prop.value = COMMENT

onnx.save(m, MODEL_PATH)
print("OK:", m.metadata_props)
