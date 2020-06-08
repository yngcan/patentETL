利用SQL对Patstat数据库进行检索
==============================

# 1.目标

本内容的目标是让同学们你能够掌握利用基础的Mysql对Patstat数据库进行检索。本文档的内容主要来自于文档 [Using PATSTAT WITH SQL v2.8](`http://documents.epo.org/projects/babylon/eponet.nsf/0/F9CDDA40F7482572C125806800350474/$File/Using_PATSTAT_with_SQL_v2.8.pptx)


# 2.内容

## 2.1关系数据库基础

### 关系数据库中表所对应的值是原子的
关系数据库中表中的每一个值都被认为是基础元素（不可再分）。

例如：
  + one IPC symbol
  + one application number
  + one abstract 

在 tls209_appln_ipc表中的ipc_class_symbol字段可能有一个值为'A61K   1/07'。该值是原子的，不可再分，这意味着没有IPC部、大类、小类、大组、小组的区分。

## 2.2关系数据库中的键

三种情况：
+ `主键`：tls201_appln表中的appln_id。主键很多是虚拟键，是指表中某属性的值能够唯一的标识表中的每一行。

+ `替代键`：tls204_appln_prior表中的appln_id 和 prior_appln_id 以及 appln_id 和prior_appln_seq_nr构成替代键。往往替代键是由具有具体含义的多个字段构成。

+ `外键`：是指表中的一个属性的值能够唯一地标识另一张表中的每一行。

举例：tls211_pat_publn表中的主键与替代键

![tls211_pat_publn_key](
https://github.com/yngcan/patentETL/blob/master/queryimages/key.png)

## 2.3基础检索式

基础检索式通常包括 `SELECT` - `FROM` - `WHERE` ,如下：

```mysql
SELECT appln_id
FROM tls201_appln
WHERE appln_auth = 'IE'
```

### 2.3.1 WHERE语句
```mysql
/*SELECT *
FROM tls201_appln*/

/* comparison operator 比较操作符 */
WHERE appln_filing_date >= '2001-01-01' # Dates are enclosed in single quotes (') and take the form YYYY-MM-DD 

WHERE appln_id <> 1234711

/* comparison operator 比较操作符-IN */
WHERE appln_auth IN ('EP', 'JP', 'US') # limit to Trilateral offices
WHERE appln_auth NOT IN ('US', 'CA')	

/* comparison operator 比较操作符-BETWEEN */
WHERE appln_filing_date BETWEEN '2001-04-01' AND '2001-09-30'
WHERE appln_filing_date >= '2001-04-01' AND appln_filing_date <= '2001-09-30' 

/* comparison operator 比较操作符-LIKE */
WHERE person_name LIKE 'SIEMENS%'
WHERE ipc_class_symbol like 'B60K%'
WHERE appln_title LIKE '%hybrid%motor%'
/* LIKE 操作符仅能针对字符串，而不能对数值或日期进行操作
   通配符(%)可以代替多个字符，也可以在字符串中任何位置出现。
   下划线(_)可以代替一个字符。*/

```

### 2.3.2 练习

构建一个检索式，检索自2005年以来所有提交的奥地利（Austrian,AT）专利申请。

 + 该检索仅使用tls201_appln表已足够；
 + 不要忘记排除实用新型(utility)专利;
 + 对于申请年为9999的专利需要排除；
 + 如果有不清楚的，请查看 《Data Catalog PATSTAT Global》。

 ```mysql
SELECT appln_id, appln_nr, appln_auth, ipr_type, appln_filing_date
FROM tls201_appln
WHERE appln_auth = 'AT' 
AND ipr_type = 'PI' # Retrieves only patents of invention (PI) and ignores utility models (UM)
AND appln_filing_year >= 2005 
AND appln_filing_year < 9999 # Returns all years from 2005 to today, while excluding the year 9999 (which stands for "date unknown"). You can also use  “AND appln_filing_year BETWEEN 2005 AND 2014” instead.

 ```

### 2.4 全文检索

 在PATSTAT GLOBAL中只有两个较长的`text`字段
 - Titles 		in table TLS202_APPLN_TITLE
 - Abstract	    in table TLS203_APPLN_ABSTR

 + 首先，我们可以利用LIKE加通配符`%`来实现。然而，LIKE检索是采用逐个字符检索的，对于一个110G的文档进行字符扫描，消耗巨大。

```mysql
SELECT
	* 
FROM
	tls202_appln_title 
WHERE APPLN_TITLE LIKE '%SOLAR%'
```
 + 可以考虑采用MYSQL的全文检索方式


```mysql
/*全文索引*/
# 增加全文索引，只能在text类型字段上增加
ALTER TABLE tls202_appln_title ADD FULLTEXT INDEX title_fulltext ( appln_title );
# 利用 MATCH —— AGAINST 检索
SELECT
	* 
FROM
	tls202_appln_title 
WHERE
	MATCH ( APPLN_TITLE ) AGAINST ( 'SOLAR' );
```

  + 比较上述两个检索式的时间；
  
  + 比较上述两个检索式的效果；

```MYSQL
SELECT
	T1.* 
FROM
	( SELECT APPLN_ID,APPLN_TITLE 
	FROM tls202_appln_title 
	WHERE APPLN_TITLE LIKE '%SOLAR%') AS T1
LEFT JOIN 
    ( SELECT APPLN_ID, APPLN_TITLE 
	FROM tls202_appln_title 
    WHERE MATCH ( APPLN_TITLE ) AGAINST ( 'SOLAR' ) ) AS T2
ON ( T1.APPLN_ID = T2.APPLN_ID 
     AND T1.APPLN_TITLE = T2.APPLN_TITLE ) 
WHERE
	T2.APPLN_ID IS NULL;
```

## 2.5 多表连接（JOIN）

  + 在PATSTAT中，专利数据由于避免冗余和存储高效被拆分为了多张表，因此，当要真正分析问题时，还需要对多表进行连接。
  
  + PATSTAT中多表之间的关系可以参见![逻辑模型图](https://github.com/yngcan/patentETL/blob/master/queryimages/logical_model.png)
  
  + 例如，分析不同的主题需要不同组合不同的表
  
  + 分析标题 - Person表的组合
  
    - PERSON表的逻辑
    ![PATSTAT——PERSON表的逻辑关系](https://github.com/yngcan/patentETL/blob/master/queryimages/person.png)
    - 发明人、申请人合并到一张表
    
    - PERSON表的检索
    ![PATSTAT——PERSON表的检索](https://github.com/yngcan/patentETL/blob/master/queryimages/person_table.png)
    
    -  如果你想通过关系数据库来了解真实的人的关系，你至少需要三张表：
       - 申请表 (tls201_appln)
       - 发明人/申请人信息表 (tls206_person)
       - 申请与发明人/申请人信息关联表 (tls207_pers_appln)

    - PERSON表的实例
      - 检索申请地为CN（中国）
      - 申请人或者发明人为EP（欧盟）
 ```MYSQL
SELECT *
from tls201_appln a
JOIN tls207_pers_appln pa on a.appln_id = pa.appln_id
JOIN tls206_person p on pa.person_id = p.person_id
where p.person_ctry_code = 'EP'
and a.appln_auth = 'CN'
 ```
 - 如何处理tls207_pers_appln关联表
   
   由于专利申请和专利申请人/发明人之间的关系是多对多，他们之间是有序号的。
   
   - 如果仅想检索专利申请人 （WHERE applt_seq_nr > 0）
   
   - 如果仅想检索发明人（invt_seq_nr > 0）
   
   - 如果又想包括申请人也想包括发明人 WHERE (applt_seq_nr > 0) AND (invt_seq_nr > 0)

   
   ```mysql
SELECT a.appln_id, appln_auth, appln_nr, appln_kind, p.person_id, p.person_name
FROM tls201_appln a
LEFT OUTER JOIN tls207_pers_appln pa ON a.appln_id = pa.appln_id
LEFT OUTER JOIN tls206_person p ON pa.person_id = p.person_id
WHERE applt_seq_nr > 0 
AND -- please complete ....
   ```


+ 标题和摘要

```mysql
SELECT a.appln_id, appln_auth, appln_nr, appln_kind, t.appln_title /*前面是替代键*/
FROM tls201_appln a
LEFT OUTER JOIN tls202_appln_title t 
ON a.appln_id = t.appln_id
WHERE /*-- please complete ....*/
```

+ 技术分类号

  - 连接技术分类号码与申请
```mysql
SELECT a.appln_id, appln_auth, appln_nr, appln_kind, i.ipc_class_symbol
FROM tls201_appln a
LEFT OUTER JOIN tls209_appln_ipc i 
ON a.appln_id = i.appln_id
WHERE /*-- please complete ....*/
```

  - 对分类号的组连接 
```MYSQL
SELECT appln_id, GROUP_CONCAT(IPC_CLASS_SYMBOL,';')
FROM tls209_appln_ipc
WHERE appln_id between 10000200 and 10000202
GROUP BY APPLN_ID
```

+ 专利家族

   - 目前，数据TLS201_APPLN包含了DOCDB_FAMILY_ID,INPADOC_FAMILY_ID
   - 其中，每一个APPLN_ID都是DOCDB_FAMILY_ID,INPADOC_FAMILY_ID的家族成员
   
```mysql
SELECT DOCDB_FAMILY_ID,COUNT(APPLN_ID) AS DOCDB_FAMILY_SIZE
FROM TLS201_APPLN
GROUP BY DOCDB_FAMILY_ID LIMIT 100;
```
   - 在此基础上可以进一步选择高专利家族专利
```MYSQL
SELECT *
FROM TLS201_APPLN
WHERE DOCDB_FAMILY_ID IN
(SELECT DOCDB_FAMILY_ID
FROM TLS201_APPLN
WHERE DOCDB_FAMILY_SIZE > 50)
```

+ 专利公开、公告
   - 一项专利往往有多项公开公告，PATSTAT是以申请为中心组织数据库的
   - 在实际中，更多地获得的是专利公开公告信息
   
```mysql
SELECT publn_nr, publn_kind, publn_date
FROM  tls211_pat_publn p 
JOIN tls201_appln a ON p.appln_id = a.appln_id
WHERE appln_filing_date = '2007-07-07'    
```

+ 专利引文
  
  - PAT_PUBLN_ID 指施引专利公开文档（the citing publication）。
  
  - CITED_PAT_PUBLN_ID 是指被引专利公开文档（a publication being cited）。
  
  - CITED_APPLN_ID 是指被引专利的申请文档（an application being cited）。
  
  - CITED_NPL_PUBLN_ID 是指被引专利的非专利文档（non-patent-literature）。

```mysql
SELECT c.citn_origin, c.pat_citn_seq_nr , p2.publn_auth, p2.publn_nr, p2.publn_kind
FROM tls211_pat_publn p1
LEFT JOIN tls212_citation c ON p1.pat_publn_id = c.pat_publn_id  
JOIN tls211_pat_publn p2 ON c.cited_pat_publn_id =  p2.pat_publn_id  
-- 以下是citations相关
WHERE c.pat_citn_seq_nr > 0    -- 检索仅包括引用专利公开文档
AND p1.publn_auth = 'EP'      -- for example 
AND p1.publn_kind = 'A1'
ORDER BY citn_origin
```
   - 专利引文关系图，根据关系来判断其引用类型。

   ![引文关系图](https://github.com/yngcan/patentETL/blob/master/queryimages/citation.png)


# 3 检索式指导

## 3.1 定位研究对象

  + Choose the right aggregation level: Are you interested in families, applications, publications or any other "units"?
  
  + What filter conditions have to be applied to limit the data?
  
  + What information should the output contain?

## 3.2 确定你的表

  + 确定你需要使用的表、属性
  
  + 确定那你分析的时间（申请日、公开日、授权日、优先权日等）
  
  + 选择适合的层次、分类

## 3.3 构造检索式

  + 构造一个简单检索式
  
  + 增加条件、限制
  
  + 循环（RUN - CHECK - ENHANCE QUERY - RUN）

## 3.4 增强检索

  + IN 操作符
  + OR 或者 LIKE 通配符
  + GROUP BY
  + 子检索和EXISTS 逻辑判断

# 4. 有用的检索式

## 4.1 根据技术领域检索专利

```mysql
/* Query1:Identification of patents by technology fields */
SELECT DISTINCT
	t1.appln_id,
	t1.appln_auth,
	t1.appln_nr,
	t1.appln_kind 
FROM
	tls201_appln t1
	INNER JOIN tls209_appln_ipc t2 
    ON t1.appln_id = t2.appln_id 
WHERE
	YEAR ( t1.appln_filing_date ) = 2005 
	AND ( t1.appln_kind = 'A' OR t1.appln_kind = 'W' ) 
	AND t2.ipc_class_symbol LIKE 'F03D%' 
ORDER BY
	t1.appln_auth,
	t1.appln_id;
```

## 4.2 计算专利家族的规模

```mysql
SELECT DOCDB_FAMILY_ID, COUNT(APPLN_ID) AS FAMILY_SIZE
FROM TLS201_APPLN
GROUP BY DOCDB_FAMILY_ID
ORDER BY FAMILY_SIZE DESC;
```
## 4.3 计算专利家族的地理规模
```MYSQL
SELECT DOCDB_FAMILY_ID, COUNT(DISTINCT APPLN_AUTH) AS FAMILY_GEO_SIZE
FROM TLS201_APPLN
GROUP BY DOCDB_FAMILY_ID
ORDER BY FAMILY_GEO_SIZE DESC;
```

## 4.4 计算发明人国际合作的情况

```mysql
SELECT
	t1.appln_id,
	COUNT( DISTINCT t3.person_ctry_code ) AS nb_locations 
FROM
	TLS201_APPLN t1
	INNER JOIN tls207_pers_appln t2 ON t1.appln_id = t2.appln_id
	INNER JOIN tls206_person t3 ON t2.person_id = t3.person_id 
WHERE
	t3.person_ctry_code IS NOT NULL 
	AND t2.invt_seq_nr > 0 
GROUP BY
	t1.appln_id 
ORDER BY
	COUNT( DISTINCT t3.person_ctry_code ) DESC,
	t1.appln_id ASC;
```

## 4.5 按照国别来统计专利贡献（简单统计、得分）
```mysql
SELECT
	person_ctry_code,
	SUM( tot_in_ctry / tot_in_patent ) AS fractional_count 
FROM
	(
	SELECT
		t.appln_id,
		ifnull( t1.person_ctry_code, '' ) AS person_ctry_code,
		ifnull( t1.tot_in_ctry, 1 ) AS tot_in_ctry,
		ifnull( t2.tot_in_patent, 1 ) AS tot_in_patent 
	FROM
		TLS201_APPLN t
		LEFT OUTER JOIN (
		SELECT
			a.appln_id,
			b.person_ctry_code,
			COUNT( b.person_id ) AS tot_in_ctry 
		FROM
			tls207_pers_appln a
			INNER JOIN tls206_person b ON a.person_id = b.person_id 
		WHERE
			a.invt_seq_nr > 0 
		GROUP BY
			a.appln_id,
			person_ctry_code 
		) t1 ON t.appln_id = t1.appln_id
		LEFT OUTER JOIN ( SELECT appln_id, MAX( invt_seq_nr ) AS tot_in_patent FROM tls207_pers_appln GROUP BY appln_id HAVING MAX( invt_seq_nr ) > 0 ) t2 ON t.appln_id = t2.appln_id 
	) our_sample_with_country 
GROUP BY
	person_ctry_code 
ORDER BY
	SUM( tot_in_ctry / tot_in_patent ) DESC;
```

## 4.7 计算专利3年内的被引频次
```mysql
SELECT
	t1.appln_id,
	COUNT( DISTINCT t3.pat_publn_id ) AS cites_3y 
FROM
	TLS201_APPLN t1
	INNER JOIN ( SELECT appln_id, MIN( publn_date ) AS earliest_date FROM tls211_pat_publn GROUP BY appln_id ) t2 ON t1.appln_id = t2.appln_id
	INNER JOIN tls211_pat_publn t2b ON t2b.appln_id = t2.appln_id
	INNER JOIN tls212_citation t3 ON t2b.pat_publn_id = t3.cited_pat_publn_id
	INNER JOIN tls211_pat_publn t4 ON t3.pat_publn_id = t4.pat_publn_id 
WHERE
	t2b.publn_auth = 'DE' 
	AND t4.publn_auth = 'EP' 
	AND YEAR ( t2.earliest_date )!= 9999 
	AND YEAR ( t4.publn_date )!= 9999 
	AND t4.publn_date <= DATE_ADD( t2.earliest_date, INTERVAL 3 YEAR ) 
GROUP BY
	t1.appln_id 
ORDER BY
	COUNT( DISTINCT t3.pat_publn_id ) DESC,
	t1.appln_id ASC;
```





