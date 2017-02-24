# student-code-analysis
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
sudo git clone http://github.com/derailment/student-code-analysis
sudo chmod a+w ./student-code-analysis
sudo php Recorder.php [item] [subitem]
sudo php Tracker.php [item] [subitem] [status]
sudo php Cleaner.php [item] [subitem]
```
