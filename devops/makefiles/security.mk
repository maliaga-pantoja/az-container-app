scan_iac:
	./devops/scripts/security.sh script_security_iac
scan_app:
	./devops/scripts/security.sh script_security_app
scan_app_sonarcloud:
	./devops/scripts/security.sh script_sonar_scanner_app