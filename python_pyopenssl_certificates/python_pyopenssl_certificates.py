#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
python_pyopenssl_certificates.py

Generates a CA certificate and 509 certificates

- Needs PyOpenSSL (pip install PyOpenSSL)
- Inspired by https://gist.github.com/eskil/2338529
- https://www.programcreek.com/python/example/83358/OpenSSL.crypto.X509Extension

@author:  Luis Martin Gil
@contact: martingil.luis@gmail.com

https://github.com/luismartingil
www.luismartingil.com
'''


from OpenSSL import crypto, SSL
from time import gmtime, mktime

BYTES=1024
TIME_UNIT=24 * 60 * 60
HASH_ALGORITHM='sha256'
SERIAL_NUMBER=1000

EXT_CERT='crt'
EXT_KEY='key'

CA_C="ES" # countryName
CA_ST='Madrid' # stateOrProvinceName
CA_L='Madrid' # localityName
CA_O='ca.sipplauncher' # organizationName
CA_OU='ca.sipplauncher' # organizationalUnitName


class CAOpenSSL(object):

    ca_cert = None
    ca_key = None

    @staticmethod
    def _create_cert_key_pair(cn):
        """ Generates a given cert and key using the CN (commonName) param
        """
        # Generate 509 cert
        cert = crypto.X509()
        cert.get_subject().C = CA_C
        cert.get_subject().ST = CA_ST
        cert.get_subject().L = CA_L
        cert.get_subject().O = CA_O
        cert.get_subject().OU = CA_OU
        cert.get_subject().CN = cn
        cert.set_serial_number(SERIAL_NUMBER)
        cert.gmtime_adj_notBefore(0)
        cert.gmtime_adj_notAfter(TIME_UNIT * 10 * 365)
        cert.set_issuer(cert.get_subject())
        # Generate key
        key = crypto.PKey()
        key.generate_key(crypto.TYPE_RSA, BYTES)
        # Signing certificate using key
        cert.set_pubkey(key)
        cert.sign(key, HASH_ALGORITHM)
        return cert, key

    @staticmethod
    def _write_cert_key_pair(cert, key, cn, prefix):
        """ Writes to disk the cert and key
        """
        cert_filename = '{0}-{1}.{2}'.format(prefix, cn, EXT_CERT)
        key_filename = '{0}-{1}.{2}'.format(prefix, cn, EXT_KEY)
        open(cert_filename, "wb").write(crypto.dump_certificate(crypto.FILETYPE_PEM, cert))
        print('Saved cert file: "{0}"'.format(cert_filename))
        open(key_filename, "wb").write(crypto.dump_privatekey(crypto.FILETYPE_PEM, key))
        print('Saved key file: "{0}"'.format(key_filename))

    def create_ca_cert(self, cn, prefix='rootCA'):
        """ Creates CA cert
        """
        self.ca_cert, self.ca_key = CAOpenSSL._create_cert_key_pair(cn)
        self.ca_cert.add_extensions([
            crypto.X509Extension(b'basicConstraints', True, b'CA:TRUE'),
            crypto.X509Extension(b'subjectKeyIdentifier', False, b'hash', subject=self.ca_cert)
        ])

        CAOpenSSL._write_cert_key_pair(self.ca_cert, self.ca_key, cn, prefix)

    def create_server_cert(self, cn, prefix='server'):
        """ Creates server cert which is CA-signed
        """
        server_cert, server_key = CAOpenSSL._create_cert_key_pair(cn)
        # Signing server certificate using ca key
        server_cert.set_issuer(self.ca_cert.get_subject())
        server_cert.sign(self.ca_key, HASH_ALGORITHM)
        CAOpenSSL._write_cert_key_pair(server_cert, server_key, cn, prefix)

ca = CAOpenSSL()
ca.create_ca_cert('ca.zaleos.net')

# Create as much as ca-signed certificates as needed
for ip in [200, 190, 191]:
    # passing CN - commonName
    cn = '10.22.22.{0}'.format(ip)
    ca.create_server_cert(cn)

"""
$ rm -f *.crt *.key ; time python test.py
Saved cert file: "rootCA-ca.zaleos.net.crt"
Saved key file: "rootCA-ca.zaleos.net.key"
Saved cert file: "server-10.22.22.200.crt"
Saved key file: "server-10.22.22.200.key"
Saved cert file: "server-10.22.22.190.crt"
Saved key file: "server-10.22.22.190.key"
Saved cert file: "server-10.22.22.191.crt"
Saved key file: "server-10.22.22.191.key"

# Tips:
# openssl x509 -in <cert> -noout -text
# openssl verify -CAfile <ca-cert> <server-cert>

$ openssl verify -CAfile rootCA-ca.zaleos.net.crt server-10.22.22.191.crt
server-10.22.22.191.crt: OK
"""
