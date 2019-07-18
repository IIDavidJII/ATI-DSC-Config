#Display current timezone
Write "******************************************************************"
Write "Check Timezone"
Write "******************************************************************"
[System.TimeZone]::CurrentTimeZone | Format-List