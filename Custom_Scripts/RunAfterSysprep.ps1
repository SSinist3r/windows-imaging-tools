# PowerShell script to configure account settings after running sysprep

# Set the account lockout threshold to 0
Invoke-Expression -Command "net accounts /lockoutthreshold:0"

# Set the maximum password age to unlimited
Invoke-Expression -Command "net accounts /maxpwage:unlimited"