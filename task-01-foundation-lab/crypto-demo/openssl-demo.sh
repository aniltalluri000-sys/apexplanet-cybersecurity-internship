#!/usr/bin/env bash
# OpenSSL hands-on demo: symmetric, hashing, asymmetric, certificate
# Run inside a scratch folder:  bash openssl-demo.sh
set -e
WORK=$(mktemp -d)
cd "$WORK"
openssl version
echo

echo "=== 1. SYMMETRIC: AES-256-CBC encrypt / decrypt ==="
echo "Task 1 secret message: Hello from the lab" > message.txt
openssl enc -aes-256-cbc -pbkdf2 -salt -in message.txt -out message.enc -pass pass:LabPass123
echo "Encrypted (base64 view):"
openssl base64 -in message.enc
echo "Decrypted:"
openssl enc -d -aes-256-cbc -pbkdf2 -in message.enc -pass pass:LabPass123
echo

echo "=== 2. HASHING ==="
echo -n "hello" | openssl dgst -sha256
echo -n "hello" | openssl dgst -md5
echo -n "hellO" | openssl dgst -sha256
echo "(note: one character changed -> completely different hash)"
echo

echo "=== 3. ASYMMETRIC: RSA key pair, encrypt with public, decrypt with private ==="
openssl genrsa -out private.pem 2048 2>/dev/null
openssl rsa -in private.pem -pubout -out public.pem 2>/dev/null
echo "Meet at 6 PM" > short.txt
openssl pkeyutl -encrypt -pubin -inkey public.pem -in short.txt -out short.rsa
echo "Ciphertext size (bytes): $(wc -c < short.rsa)"
echo "Decrypted:"
openssl pkeyutl -decrypt -inkey private.pem -in short.rsa
echo

echo "=== 4. DIGITAL SIGNATURE ==="
openssl dgst -sha256 -sign private.pem -out sig.bin message.txt
openssl dgst -sha256 -verify public.pem -signature sig.bin message.txt
echo

echo "=== 5. SELF-SIGNED CERTIFICATE ==="
openssl req -x509 -newkey rsa:2048 -nodes -keyout key.pem -out cert.pem -days 365 \
  -subj "/C=IN/ST=Gujarat/L=Rajkot/O=Lab/CN=lab.local" 2>/dev/null
openssl x509 -in cert.pem -noout -subject -issuer -dates -fingerprint -sha256
echo
echo "Done. Working files in: $WORK"
