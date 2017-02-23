<?php 
/**
 * Fetch students' submission records from TAFree
 *
 * @authur Yu Tzu Wu <abby8050@gmail.com>
 * @license MIT
 */

ini_set('display_errors', '1');
ERROR_REPORTING(E_ALL);

interface Filter {
	const TESTER_ACCOUNT = 'r03521602';
	const ITEM = 'Lab01';
    const SUBITEM = 1;
}

class Recorder {
	
	private $item;
	private $subitem;
	private $tester;
	private $handle;
	private $filename;
	private $fields;
	
	public function __construct() {
		
		// Get item, subitem
		$this->item = Filter::ITEM;	
		$this->subitem = Filter::SUBITEM;
		$this->tester = Filter::TESTER_ACCOUNT;
		
		// Configure csv file	
		$this->filename = $this->item . '_' . $this->subitem . '.csv';
		$this->handle = fopen($this->filename, 'w');
		
		// Configure title
        $this->fields = array();
        $timestamp = 'Timestamp';
        $student_name = 'Student Name';
        $student_account = 'Student Account';
        $status = 'Status'; 
        array_push($this->fields, $timestamp);
        array_push($this->fields, $student_name);
        array_push($this->fields, $student_account);
        array_push($this->fields, $status);
        fputcsv($this->handle, $this->fields);
        
        // Configure content
		try {
			$this->hookup = UniversalConnect::doConnect();
			
			$stmt = $this->hookup->prepare('SELECT * FROM process WHERE item=\'' . $this->item . '\' AND subitem=\'' . $this->subitem . '\' AND student_account!=\'' . $this->tester . '\'');
			$stmt->execute();
			$this->fields = array();
			while($row = $stmt->fetch(\PDO::FETCH_ASSOC)) {
                array_push($this->fields, $row['timestamp']);
				array_push($this->fields, $row['student_name']);
				array_push($this->fields, $row['student_account']);
				array_push($this->fields, $row['status']);
				fputcsv($this->handle, $this->fields);
				$this->fields = array();				
			}	
	
			$this->hookup = null;
			
		}
		catch (\PDOException $e) {
			echo 'Error: ' . $e->getMessage() . '<br>';
		}		
		
		fclose($this->handle);
		
	}
}

interface IConnectInfo {
	const HOST = '45.32.107.147';
	const UNAME = 'derailment';
	const PW = 'ewre3571';
	const DBNAME = 'TAFreeDB';
	public static function doConnect();
}

class UniversalConnect implements IConnectInfo {
	
	private static $servername = IConnectInfo::HOST;
	private static $dbname = IConnectInfo::DBNAME;
	private static $username = IConnectInfo::UNAME;
	private static $password = IConnectInfo::PW;
	private static $conn;
	public static function doConnect() {
		self::$conn = new \PDO('mysql:host=' . self::$servername . ';dbname=' . self::$dbname, self::$username, self::$password);
		self::$conn->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
		return self::$conn;	
	}
}

$recorder = new Recorder();

?>
