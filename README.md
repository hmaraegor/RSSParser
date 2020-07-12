# RSSParser

NewsFeedController was unload in [master](https://github.com/hmaraegor/RSSParser/tree/master) branch. 
All methods, with related with table view data source and table view delegate are implemented in DataProvider(controller for work with table view).
Data is separated from the controller and DataProvider. They are in DataManager(class for work with data).

In [massiveViewController](https://github.com/hmaraegor/RSSParser/tree/massiveViewController) branch NewsFeedController conforming table view data source and table view delegate protocols. And all data contains in NewsFeedController.
