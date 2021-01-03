## 1. Preparation

### 1-1. JSON File for Import

1. Create learning data CSV file to import Q&As all at once on Botpress.
  * Place headers `Serial_Nums`, `Questions` and `Answers`
  * Remove HTML tags and quotes to avoid an error raised by CSV library of Python
  * Duplicate `Serial_Nums` and `Answers`(`Serial_Nums & Answers`: `Questions` = 1:N ).
  * For the details, check the [Sample](https://github.com/oasis-forever/botpress_inspection_tool_kit_rb/blob/master/csv/learning_data.csv)
2. In `/exec_json_generator.rb`, assign CSV file path for import to 1st argument and JSON file path for export in generating a new `JsonConverter` instance.
```ruby
JsonConverter.new('./csv/learning_data.csv', './json/learning_data.json')
```
3. Run `ruby exec_json_generator.rb`.

### 1-2. Test Data

Create test data CSV file.

* Place headers `Serial_Nums`, `Questions` and `Answers`
* `Serial_Nums` : `Questions` : `Answers` : = 1:1:1
* For the details, check the [Sample](https://github.com/oasis-forever/botpress_inspection_tool_kit_py/blob/master/csv/test_data.csv)
