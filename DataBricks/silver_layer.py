# Databricks notebook source
# MAGIC %md
# MAGIC # SILVER LAYER SCRIPT

# COMMAND ----------

# MAGIC %md
# MAGIC ### DATA ACCESS USING APP

# COMMAND ----------

spark.conf.set("fs.azure.account.auth.type.adlsgen2adventure11.dfs.core.windows.net", "OAuth")
spark.conf.set("fs.azure.account.oauth.provider.type.adlsgen2adventure11.dfs.core.windows.net", "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider")
spark.conf.set("fs.azure.account.oauth2.client.id.adlsgen2adventure11.dfs.core.windows.net", "2375b67d-f704-4398-8c53-1f48861de6fa")
spark.conf.set("fs.azure.account.oauth2.client.secret.adlsgen2adventure11.dfs.core.windows.net", "G.E8Q~Ww-W0tMor9LziEoBM1KqXm_KXnLTz_nb88")
spark.conf.set("fs.azure.account.oauth2.client.endpoint.adlsgen2adventure11.dfs.core.windows.net", "https://login.microsoftonline.com/e39d3020-2c97-4db1-ba4c-8f27d1d8be8b/oauth2/token")

# COMMAND ----------

# MAGIC %md
# MAGIC ### DATA LOADING

# COMMAND ----------

# MAGIC %md
# MAGIC Reading Data

# COMMAND ----------

df_cal = spark.read.format('csv')\
        .option("header",True)\
        .option("inferSchema",True)\
        .load('abfss://bronze@adlsgen2adventure11.dfs.core.windows.net/AdventureWorks_Calendar')

# COMMAND ----------

df_cus = spark.read.format('csv')\
        .option("header",True)\
        .option("inferSchema",True)\
        .load('abfss://bronze@adlsgen2adventure11.dfs.core.windows.net/AdventureWorks_Customers')

# COMMAND ----------

df_procat = spark.read.format('csv')\
        .option("header",True)\
        .option("inferSchema",True)\
        .load('abfss://bronze@adlsgen2adventure11.dfs.core.windows.net/AdventureWorks_Product_Categories')

# COMMAND ----------

df_prosub = spark.read.format('csv')\
        .option("header",True)\
        .option("inferSchema",True)\
        .load('abfss://bronze@adlsgen2adventure11.dfs.core.windows.net/AdventureWorks_Product_Subcategories')

# COMMAND ----------

df_pro = spark.read.format('csv')\
        .option("header",True)\
        .option("inferSchema",True)\
        .load('abfss://bronze@adlsgen2adventure11.dfs.core.windows.net/AdventureWorks_Products')

# COMMAND ----------

df_ret = spark.read.format('csv')\
        .option("header",True)\
        .option("inferSchema",True)\
        .load('abfss://bronze@adlsgen2adventure11.dfs.core.windows.net/AdventureWorks_Returns')

# COMMAND ----------

df_sale = spark.read.format('csv')\
        .option("header",True)\
        .option("inferSchema",True)\
        .load('abfss://bronze@adlsgen2adventure11.dfs.core.windows.net/AdventureWorks_Sales*')

# COMMAND ----------

df_ter = spark.read.format('csv')\
        .option("header",True)\
        .option("inferSchema",True)\
        .load('abfss://bronze@adlsgen2adventure11.dfs.core.windows.net/AdventureWorks_Territories')

# COMMAND ----------



# COMMAND ----------



# COMMAND ----------

