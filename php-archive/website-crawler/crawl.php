<title>Web Crawler Results</title><style>	body		{			font-family: "Segoe UI Light","Segoe WPC","Segoe UI",              Helvetica, Arial, "Arial Unicode MS", Sans-Serif;			font-style: normal;			font-variant: normal;			font-weight: 500;			font-size:18px;		}</style><?php$to_crawl = $_POST['url'];$c = array();function get_links($url){global $c;$input = @file_get_contents($url);$regexp = "<a\s[^>]*href=(\"??)([^\">]*?)\\1[^>]*>(.*)<\/a>";preg_match_all("/$regexp/siU",$input,$matches);$base_url = parse_url($url,PHP_URL_HOST);$l = $matches[2];foreach($l as $link)	{		if(strpos($link,"#"))			{				$link = substr($link,0,strpos($link,"#"));			}		if(substr($link,0,1) == ".")			{				$link = substr($link,1);			}		if(substr($link,0,7) == "http://")			{				$link = $link;			}		else if(substr($link,0,8) == "https://")			{				$link = $link;			}		else if(substr($link,0,2) == "//")			{				$link = substr($link,2);			}		else if(substr($link,0,1) == "#")			{				$link = $url;			}		else if(substr($link,0,7) == "mailto:")			{				$link = "[".$link."]";			}			else			{				if(substr($link,0,1) != "/")					{						$link = $base_url."/".$link;					}				else					{						$link = $base_url.$link;					}			}		if((substr($link,0,7) != "http://") && (substr($link,0,8) != "https://") && (substr($link,0,1) != "["))			{				if(substr($url,0,8) == "https://")				{					//prepend https					$link = "https://".$link;				}				else				{					//prepend http					$link = "http://".$link;				}			}		if(!in_array($link,$c))			{				array_push($c,$link);			}	}}get_links($to_crawl);foreach($c as $page){	get_links($page);}foreach($c as $page){	echo "<a href =".$page." target = '_blank'>".$page."</a><br/>";}?>