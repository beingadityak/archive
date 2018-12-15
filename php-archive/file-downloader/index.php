<?php
class Download
{
	const URL_MAX_LENGTH = 2050;

	/*cleaning the URL*/
	protected function cleanUrl($url)
		{
			if(isset($url))
			{
				if(!empty($url))
				{
					if($url < self::URL_MAX_LENGTH)
					{
						return strip_tags($url);
					}
				}
			}
		}

	/*is it a URL ?*/

	protected function isUrl($url)
	{
		$url = $this->cleanUrl($url);
		if(isset($url))
		{
			if(filter_var($url,FILTER_VALIDATE_URL,FILTER_FLAG_PATH_REQUIRED))
			{
				return $url;
			}
		}
	}

	/*getting the extension of the URL*/

	protected function returnExtension($url)
	{
		if($this->isUrl($url))
		{
			$end = end(preg_split("/[.]+/", $url));
			if(isset($end))
			{
				return $end;
			}
		}
	}

	/*public method for downloading the file/webpage*/

	public function downloadFile($url)
	{
		if($this->isUrl($url))
		{
			$extension = $this->returnExtension($url);
			if($extension)
			{
				$ch = curl_init();
				curl_setopt($ch, CURLOPT_URL, $url);
				curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
				$return = curl_exec($ch);
				curl_close($ch);

				/*I/O Part*/
				$date = date("d-m-Y");
				$destination = "downloads/file.$date.$extension";
				$file = fopen($destination,"w+");
				fputs($file, $return);

				if(fclose($file))
				{
					echo "File Downloaded Succesfully !";
				}
			}
		}
	}
}

$obj = new Download();
if(isset($_GET['url']))
	{
		$url = $_GET['url'];
	}
?>

<form action="index.php">
	File/Webpage download URL : <input type = "text" name = "url" maxlength="2000" />
	<input type="submit" value = "Download"/>
</form>

<?php
if(isset($url))
	{
		$obj->downloadFile($url);
	}
?>