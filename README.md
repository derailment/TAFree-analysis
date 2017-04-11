# TAFree-analysis
Here are analytic tools for performing usage of TAFree Online Judge in first programming course.
  
## Configuration
Please change database information in *.example*
```
interface IConnectInfo {
	const HOST = '45.32.107.147';
	const UNAME = 'account';
	const PW = 'password';
	const DBNAME = 'TAFreeDB';
	public static function doConnect();
}
```
  
## Build and Run
```
sudo git clone http://github.com/derailment/TAFree-analysis
sudo chmod a+w ./TAFree-analysis
cd ./TAFree-analysis
sudo php Recorder.php Lab01 1
sudo php Tracker.php Lab01 1 AC
sudo php Cleaner.php Lab01 1
sudo php Mover.php ./log/Lab01/Lab01_1.csv
sudo php Accumulator.php Lab01 1
sudo php Fetcher.php Lab01 Lab02 Lab03 Lab04
```
