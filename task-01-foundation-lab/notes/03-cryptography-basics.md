# 03. Cryptography Basics

## Symmetric vs Asymmetric Encryption

| | Symmetric | Asymmetric |
|---|---|---|
| Keys | One shared secret key | Key pair: public + private |
| Speed | Fast, good for bulk data | Slower |
| Problem | Securely sharing the key | Higher computation cost |
| Algorithms | AES, ChaCha20, (3DES legacy) | RSA, ECC, Diffie-Hellman |
| Use | Encrypting files, disks, TLS session data | Key exchange, digital signatures, certificates |

In practice (TLS): asymmetric crypto establishes a shared key, then symmetric crypto encrypts the traffic.

## Hashing

A one-way function that turns any input into a fixed-length digest. A small input change produces a completely different hash.

| Algorithm | Output | Status |
|---|---|---|
| MD5 | 128-bit | Broken (collisions), do not use for security |
| SHA-1 | 160-bit | Deprecated |
| SHA-256 | 256-bit | Secure, widely used |

Uses: file integrity checks, password storage (with salt and a slow hash such as bcrypt/Argon2), digital signatures.

## Digital Certificates and SSL/TLS

- A **digital certificate** (X.509) binds a public key to an identity, and is signed by a trusted **Certificate Authority (CA)**.
- It contains: subject, issuer, public key, validity dates, signature.
- **TLS handshake (simplified):** client hello -> server hello + certificate -> client verifies certificate -> key exchange -> both derive session keys -> encrypted communication.
- Chain of trust: server certificate -> intermediate CA -> root CA (trusted by the OS/browser).

## Hands-on with OpenSSL

See `../crypto-demo/openssl-demo.sh` and `../crypto-demo/sample-output.txt`. It covers:

1. AES-256 encrypt and decrypt a message
2. SHA-256 and MD5 hashing, and showing the avalanche effect
3. RSA key pair generation, encrypting with the public key and decrypting with the private key
4. Creating and inspecting a self-signed certificate
