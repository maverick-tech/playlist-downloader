require "selenium-webdriver"

if ARGV.length > 0 
playlist_name = ARGV[0]
else
	puts "Enter Playlist Name : "
	playlist_name = gets.chomp
end

main_url = "http://youtube.com"

begin
	driver = Selenium::WebDriver.for :chrome  #create driver to handle chrome
	wait = Selenium::WebDriver::Wait.new(:timeout => 10) #wait object to wait till the element is loaded
	driver.get main_url  #open youtube.com in chrome 
	
	if main_url == "http://youtube.com"
		search_box = driver.find_element(:xpath,"/html/body/ytd-app/div/div/ytd-masthead/div[3]/div[2]/ytd-searchbox/form/div/div[1]/input") #find searchbox
		search_button = driver.find_element(:xpath,"/html/body/ytd-app/div/div/ytd-masthead/div[3]/div[2]/ytd-searchbox/form/button") #find search button

		search_box.send_keys playlist_name
		search_button.click

		first_item = wait.until { driver.find_element(:xpath,"/html/body/ytd-app/div/ytd-page-manager/ytd-search/div[1]/ytd-two-column-search-results-renderer/div/ytd-section-list-renderer/div[2]/ytd-item-section-renderer/div[3]/ytd-playlist-renderer[1]/div/a/h3/span") }
		first_item.click
	end

	current = wait.until { driver.find_element(:xpath,"//*[@id='publisher-container']/div/yt-formatted-string/span[1]") }
	final = wait.until { driver.find_element(:xpath,"//*[@id='publisher-container']/div/yt-formatted-string/span[3]") }
	from = current.text.to_i
	to= final.text.to_i


	for i in from..to

		song_link = driver.current_url

		driver.navigate.to "https://ytmp3.cc/en13/" 

		search_mp3 = driver.find_element(:xpath,"/html/body/div[2]/div[1]/div[1]/form/input[1]")

		search_mp3.send_keys song_link

		convert_button = driver.find_element(:xpath,"/html/body/div[2]/div[1]/div[1]/form/input[2]")

		convert_button.click

		sleep(5)
		download_song = wait.until { driver.find_element(:xpath,"//*[@id='buttons']/a[1]") }

		original_window = driver.window_handle

		download_song.click

		driver.switch_to.window original_window
		
		#driver.close
		main_url = song_link
		driver.navigate.back

		sleep(5)
		song_name = driver.title
		driver.action.key_down(:shift).send_keys('n').key_up(:shift).perform

		puts "#{song_name} is downloaded"

	end

rescue
	begin
		driver.quit
	rescue
		retry
	end
	retry

ensure
	driver.quit
end	