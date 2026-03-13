# Documentation of Thmanyah Task

# توثيق مهمة ثمانية

---

## English

### 1. Brief Problem Summary

The task was about developing a **home page whose layout depends on the API response**, as opposed to having a fixed layout. The main challenges I faced were:

- Building support for multiple kinds of sections and matching the view being displayed with its correct type.
- Building a mechanism that could extract the type of section from the response, as well as build out the sections in the correct display order on the home page.

So the home page is dynamic in that it relies on the types of sections and their display order being returned in the backend API and each type of section has a unique view associated with it.

### 2. Challenges and Difficulties

**Varying API Responses**  
The backend response wasn't consistent in every way. One main inconsistency was 'order' field in the API response; it will sometimes return Answer 'order' as Int & sometimes as a String, resulting in requiring custom decoding logic and making it difficult to create one 'Codable' model that we can rely on. Before being able to decode the response into sections, I had to accommodate those differences explicitly (e.g., decoding order values one at a time, or building custom logic to deal with) as opposed to accomplished using a single line of code.

**UI Tests**  
I don't typically do UI tests as part of my daily work but I'm aware of them. So, writing and getting satisfactory results from ui tests took some extra time, as well as iterations.

### 3. Suggestions for Improved Standardization of Response Types

**Consistent response types**  
Responses from the API need to be uniform. All responses should have consistent return types. For example, the `order` field should always be an integer. Improvements to the API's return consistency would provide the following benefits:

- Consistent response data types would make decoding of API responses easier and allow for the safe use of Codable with no special case logic needed.
- Reducing the amount of one-off decoded values and increased ease of maintaining code by utilizing a single common coding structure.

### 4. Relationship with Company Brand Values

Thmanyah is committed to enriching the Arabic language and its use in any internal/external business context possible; I feel that as an Arabic speaker, I have a responsibility to use the Arabic language and promote its use on a daily basis both through my personal efforts and those of the company I work for. The company shares this same value of commitment toward producing content for an Arab audience written in the Arabic language and using that language in all interactions between employees and customers.

---

---

## العربية

### ١. شرح موجز للمشكلة

المهمة كانت تتعلق ببناء **شاشة رئيسية يقودها backend**. هذا يعني أن واجهة المستخدم تستند إلى استجابة الـ API بدلاً من تخطيط ثابت. المطلوب كان:

- دعم **أنواع متعددة من الأقسام/الخلايا** وعرض الواجهة المناسبة لكل نوع.
- **تحليل الاستجابة** لتحديد نوع كل قسم وعرض الأقسام **بالترتيب الصحيح**.

بهذه الطريقة، تصبح الشاشة الرئيسية ديناميكية. تأتي أنواع الأقسام وترتيبها من الخادم، ويربط التطبيق كل نوع بالواجهة المناسبة.

### ٢. التحديات والصعوبات

**عدم اتساق استجابة الـ API**  
استجابة `backend` لم تكن متسقة تماماً. على سبيل المثال، حقل `order` يظهر أحياناً كـ `Int` وأحياناً كـ `String`. هذا تطلب منطق فك ترميز مخصص وجعل الاعتماد على نموذج `Codable` واحد أصعب. كان عليّ التعامل مع هذه الاختلافات بشكل مباشر، مثل فك الترميز واحداً تلو الآخر أو استخدام منطق مخصص بدلاً من فك ترميز مباشر.

**اختبارات الواجهة**  
لا أستخدم اختبارات الواجهة كثيراً في عملي اليومي، رغم معرفتي بها. استغرق إنهاء اختبارات الواجهة بشكل صحيح وقتاً إضافياً وجهوداً متعددة.

### ٣. أفكار واقتراحات للتحسين

**اتساق أنواع الحقول في الاستجابة**  
توحيد الـ API بحيث يكون لنفس الحقل نفس النوع دائماً، مثل أن يكون `order` إما `Int` دائماً أو `String` دائماً في كل الأقسام. هذا سيساعد على:

**باستخدام `Codable` بأمان**

- تبسيط فك الترميز والسماح دون حالات خاصة.
- تقليل الحاجة لفك الترميز يدوياً أو بشكل مخصص، مما يسهل صيانة الكود.

### ٤. الانسجام مع هوية الشركة

**إثراء اللغة العربية**
جزء من هوية ثمانية هو إثراء اللغة واستخدامها في التعاملات الداخلية والخارجية عند الحاجة. بالنسبة لي،
العربية هي لغتنا، وأنا أعتز بها كثيراً

**نشرها واستخدامها في شؤون حياتنا**
ليس تعلمها فقط، بل، لأننا نقدرها. هذا يتوافق مع التزام الشركة باللغة العربية وإنتاج محتوى يخدم المتحدثين بها.
