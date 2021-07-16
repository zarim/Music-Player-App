import datetime
import jwt


secret = """-----BEGIN PRIVATE KEY-----
MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgwj9XnbWp6/W6Fq1p
cKakvgGe0RK+AmNs0dTrV5QMGsmgCgYIKoZIzj0DAQehRANCAAS9+sEYO1Sf48ve
gcwvIWBKtx1myMssFcOby3BadkFrBfFDcD9OOwgJ855Nt9kD8emaGOpQw/OCy2Nb
Vovd0Z2s
-----END PRIVATE KEY-----"""
keyId = "RUSNWN33W4"
teamId = "PYR9TEV225"
alg = 'ES256'

time_now = datetime.datetime.now()
time_expired = datetime.datetime.now() + datetime.timedelta(hours=4380)

headers = {
	"alg": alg,
	"kid": keyId
}

payload = {
	"iss": teamId,
	"exp": int(time_expired.strftime("%s")),
	"iat": int(time_now.strftime("%s"))
}


if __name__ == "__main__":
	"""Create an auth token"""
	token = jwt.encode(payload, secret, algorithm=alg, headers=headers)

	print("----TOKEN----")
	print(token)

	print("----CURL----")
	print("curl -v -H 'Authorization: Bearer %s' \"https://api.music.apple.com/v1/catalog/us/artists/36954\" " % (token))
