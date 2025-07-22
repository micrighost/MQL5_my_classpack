# ClassPack

## 簡介
`ClassPack` 是一個用於交易的輔助類，提供了一些常用的功能，包括檢查新柱形、刪除所有掛單、平倉所有持倉以及獲取當前時間和日期的字符串表示。這個類可以幫助交易者更方便地管理交易和時間。

## 功能
### 主要功能
- **檢查新柱形**: `bool isnewbar()` - 檢查是否有新柱形產生，如果有新柱形，返回 `true`；否則返回 `false`。
- **刪除所有掛單**: `void delete_all_pending_orders()` - 刪除所有掛單。
- **平倉所有持倉**: `void close_all_positions()` - 平倉所有持倉。
- **獲取當前時間**: `string current_time() const` - 獲取當前時間的字符串表示（包含日期和時間），返回格式為 "YYYY.MM.DD HH:MM:SS"。
- **獲取當前日期**: `string current_time_date() const` - 獲取當前日期的字符串表示，返回格式為 "YYYY.MM.DD"。
- **獲取當前時間（秒）**: `string current_time_seconds() const` - 獲取當前時間（僅秒）的字符串表示，返回格式為 "HH:MM:SS"。

## 安裝步驟
1. 將 `classpack.mqh` 文件放入 MetaTrader 5 的 `Include` 目錄中。
2. 在你的專家顧問或指標中包含此文件：
   ```mql5
   #include <classpack.mqh>
   ```
3. 創建 `ClassPack` 的實例以使用其功能：
	```mql5
	ClassPack CPack;
	```

## 使用說明

- **檢查新柱形**:
	```mql5
	if (CPack.isnewbar()) {
		// 有新柱形
	}
	```

- **刪除所有掛單**:
	```mql5
	CPack.delete_all_pending_orders();
	```

- **平倉所有持倉**:
	```mql5
	CPack.close_all_positions();
	```

- **獲取當前時間**:
	```mql5
	string currentTime = CPack.current_time();
	```

- **獲取當前日期**:
	```mql5
	string currentDate = CPack.current_time_date();
	```

- **獲取當前時間（秒）**:
	```mql5
	string currentSeconds = CPack.current_time_seconds();
	```

注意事項

使用此類時，請確保在適當的上下文中調用其方法，特別是在交易操作中。
在使用平倉和刪除掛單功能時，請謹慎操作，以免意外關閉或刪除重要的交易。
