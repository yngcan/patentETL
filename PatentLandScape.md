# PatentLandscape 制作规范
==============================

## 专利统计分析报告中可以包括的统计类型

  + Number of Inventions
    - 这是最基础的统计信息，主要是对数据有一个初步了解；
    - 可以增加年份、国别维度
    - 也可以增加不同类型的年份维度（优先权、申请、公开、授权）
  
  + Number of Granted Patents
    - 授权专利数量
    - 考虑增加年份
    - 可以用`stacked bar chart`来展示授权专利相对于申请的比例。
  
  + Top Technology Categories and/or IPC Classifications
    - 可以做一个矩阵，X轴表示分类、Y轴展示数量；
    - 可进一步观察TOP APPLICANTS、利用气泡图
  
  + Top Applicants/Assignees
    - 观察每一类技术类型在该公司所占比列
    - 可以考虑专利申请人的类型（INDUSTRY\GOVERNMENT\UNIVERSITY\INDIVIDUAL）
    - 申请人网络（co-applicants）
  
  + Top Inventors
    - 发明人的国别
    - 发明人的国际流动
    - 发明人网络（co-inventors）
  
  + Citation
    - 最重要的专利质量评价指标
    - 引用国别的差异
    - 引用类型的差异
    - 专利引用网络
    
  + Family
    - 专利家族规模
    - 专利家族的布局
    - 三方专利家族
    
  + 标题、摘要
    - 词频分析
    - 主题模型（聚类分析）

## 专利统计分析报告中推荐的图标类别

### 专利申请时间线面积图
  + 左侧数量、时间
  + 右侧图标（面积）
  + 分阶段

![专利申请时间线面积图](/Users/yangguancan/Files/Python/PatentDatabase/queryimages/timeline.png)




### 专利申请时间线线图

 ![专利申请时间线线图](/Users/yangguancan/Files/Python/PatentDatabase/queryimages/timelinecategory.png)

![专利申请时间线线图](/Users/yangguancan/Files/Python/PatentDatabase/queryimages/applicanttimeline.png)

### 国别申请分布图

 ![国别申请分布图](/Users/yangguancan/Files/PatentDatabase/queryimages/countrydist.png?_xsrf=2%7C7759b8de%7C7d3bbb4c4ec2f99c5359ef87fe1c859c%7C1590139598)

### 专利申请保护策略

![专利申请保护策略](/Users/yangguancan/Files/PatentDatabase/queryimages/protectstrategy.png?_xsrf=2%7C7759b8de%7C7d3bbb4c4ec2f99c5359ef87fe1c859c%7C1590139598)

### 申请人的技术布局

![申请人的技术布局1](/Users/yangguancan/Files/PatentDatabase/queryimages/applicantdist1.png?_xsrf=2%7C7759b8de%7C7d3bbb4c4ec2f99c5359ef87fe1c859c%7C1590139598)
![申请人的技术布局2](/Users/yangguancan/Files/PatentDatabase/queryimages/applicantdist2.png?_xsrf=2%7C7759b8de%7C7d3bbb4c4ec2f99c5359ef87fe1c859c%7C1590139598)

### 核心发明人技术布局比较
![核心发明人技术布局比较](/Users/yangguancan/Files/PatentDatabase/queryimages/applicantcompare.png?_xsrf=2%7C7759b8de%7C7d3bbb4c4ec2f99c5359ef87fe1c859c%7C1590139598)

### 核心发明人技术开发周期比较

![核心发明人技术开发周期比较](/Users/yangguancan/Files/PatentDatabase/queryimages/applicanttimeline.png?_xsrf=2%7C7759b8de%7C7d3bbb4c4ec2f99c5359ef87fe1c859c%7C1590139598)

### 核心发明人质量指标评价
![核心发明人质量指标评价](/Users/yangguancan/Files/PatentDatabase/queryimages/qualityevaluation.png?_xsrf=2%7C7759b8de%7C7d3bbb4c4ec2f99c5359ef87fe1c859c%7C1590139598)

### 专利申请的地理分布

![专利申请的地理分布](/Users/yangguancan/Files/PatentDatabase/queryimages/geolocation.png?_xsrf=2%7C7759b8de%7C7d3bbb4c4ec2f99c5359ef87fe1c859c%7C1590139598)

### 技术组合分析
![技术组合分析](/Users/yangguancan/Files/PatentDatabase/queryimages/techoverlap.png?_xsrf=2%7C7759b8de%7C7d3bbb4c4ec2f99c5359ef87fe1c859c%7C1590139598)



​    
