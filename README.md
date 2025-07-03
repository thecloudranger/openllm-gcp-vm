# OpenLLM on Google Cloud VM (NVIDIA L4)

This project lets you deploy an OpenLLM server on a Google Compute Engine VM with GPU support (NVIDIA L4).

---

## 🚀 How it works

- Provisions a VM with NVIDIA GPU (e.g., L4)
- Installs drivers + CUDA + Python venv + OpenLLM
- Uses `systemd` to run OpenLLM at boot
- Exposes the `/chat` UI on your public IP

---

## 🗂️ Files in this repo

| File | Purpose |
|------|---------|
| `startup.sh` | Run this on a fresh VM to install all dependencies |
| `openllm.service` | Example systemd unit file to run OpenLLM automatically |
| `benchmark.py` | Script to test completions and tokens/sec |

---

## ✅ Steps to use

1. **Provision your VM**

   Use an L4 (or A100) machine with enough RAM and VRAM.

2. **Run the setup**

   ```bash
   chmod +x startup.sh
   ./startup.sh
   ```
   This installs CUDA, drivers, Python, and OpenLLM.

3. **Edit & copy `openllm.service`**
   ```bash
   sudo cp openllm.service /etc/systemd/system/openllm.service
   sudo systemctl daemon-reload
   sudo systemctl enable openllm
   sudo systemctl start openllm
   ```
   Update the `ExecStart` model to your choice!

4. **Test**
   - Open http://YOUR_EXTERNAL_IP/chat
   - Or call the API:
   ```bash
    curl http://127.0.0.1:3000/v1/completions \
      -H "Content-Type: application/json" \
      -d '{"prompt": "Say hi", "max_tokens": 20}'
   ```

5. **Benchmark**
   ```bash
    python3 benchmark.py
   ```   

6. **Stop & start**
   ```bash
    gcloud compute instances stop YOUR_VM
    gcloud compute instances start YOUR_VM
   ```

## ⚡Tips
- Reserve a static IP if you want a fixed public endpoint.
- Watch GPU usage: watch -n 1 nvidia-smi.
- Tune your model in ExecStart or switch it later.

## 📜 License
MIT — do whatever you want!

