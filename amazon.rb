require "selenium-webdriver"

=begin
	
rescue Exception => e
	
end
if ARGV.length > 0 
playlist_name = ARGV[0]
else
	puts "Enter Product Name : "
	playlist_name = gets.chomp
=end

main_url = "https://amazon.in"

begin
	driver = Selenium::WebDriver.for :chrome  #create driver to handle chrome
	wait = Selenium::WebDriver::Wait.new(:timeout => 100) #wait object to wait till the element is loaded
	driver.get main_url  #open youtube.com in chrome 



	#driver.find_element(:xpath,"/html/body/div[1]/header/div/div[1]/div[2]/div/a[2]/div/span").click
	##sleep(5)
	#driver.find_element(:xpath,"/html/body/div[1]/div[1]/div[2]/div/div[2]/div/div[1]/form/div/div/div/div[1]/input[1]").send_keys "tarlemanmohan@gmail.com"
	#driver.find_element(:xpath,"/html/body/div[1]/div[1]/div[2]/div/div[2]/div/div[1]/form/div/div/div/div[2]/span/span/input").click
	#driver.find_element(:xpath,"/html/body/div[1]/div[1]/div[2]/div/div[2]/div[1]/div/div/form/div/div[1]/input").send_keys "Maverick@1399"
	#driver.find_element(:xpath,"/html/body/div[1]/div[1]/div[2]/div/div[2]/div[1]/div/div/form/div/div[2]/span/span/input").click

	for i in 1..3

	driver.find_element(:xpath,"/html/body/div[1]/header/div/div[1]/div[3]/div/form/div[3]/div[1]/input").send_keys "Earphones"
	driver.find_element(:xpath,"/html/body/div[1]/header/div/div[1]/div[3]/div/form/div[2]/div/input").click
	
	first_item = wait.until { driver.find_element(:xpath,"/html/body/div[1]/div[2]/div[1]/div[2]/div/span[3]/div[2]/div[2]/div/span/div/div/div/div/div[2]/div[2]/div/div[1]/div/div/div[1]/h2/a/span") }
											
	first_item.click
	sleep(5)																			
	driver.switch_to.window(driver.window_handles[1])
	sleep(5)
	buy_now = wait.until { driver.find_element(:xpath,"/html/body/div[2]/div[2]/div[4]/div[5]/div[1]/div[3]/div/div/div/form/div/div/div/div/div[2]/div/div[29]/div[1]/span/span/span/input") }
	buy_now.click
	sleep(5)
	driver.switch_to.window(driver.window_handles[0])
	driver.navigate.refresh
	driver.close

	
	
	sleep(5)

=begin
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

		driver.navigate.to "https://en.savefrom.net/18/" 

		search_video = driver.find_element(:xpath,"/html/body/div/div[1]/div[1]/div/div[1]/div[2]/div/form/div[1]/div/input")

		search_video.send_keys song_link

		convert_button = driver.find_element(:xpath,"//*[@id='sf_submit']")

		convert_button.click

		sleep(15)
		download_song = wait.until { driver.find_element(:xpath,"//*[@id='sf_result']/div/div/div[2]/div[2]/div[1]/a") }

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
=end


ensure
	driver.quit
end	