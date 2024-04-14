### Документация: Применение паттерна "Цепочка обязанностей" в приложении онлайн-магазина

#### Введение

Этот документ описывает применение паттерна проектирования "Цепочка обязанностей" (Chain of Responsibility) в приложении онлайн-магазина, написанном на языке программирования Dart с использованием фреймворка Flutter. Паттерн "Цепочка обязанностей" используется для организации и управления различными видами обработки запросов или операций, где каждый обработчик может самостоятельно обработать запрос или передать его дальше по цепочке.

#### Кодовая база

Пример кода, предоставленный для анализа, реализует базовую структуру онлайн-магазина, где пользователь может просматривать продукты и осуществлять их покупку. В коде используется следующий набор классов:

- **Product (Продукт)**:
  - Класс `Product` представляет товар в магазине и содержит информацию о его имени, цене и изображении.
- **Handler (Обработчик)**:
  - Абстрактный класс `Handler` определяет интерфейс для обработчиков запросов. Он содержит ссылку на следующий обработчик в цепочке и абстрактный метод `processRequest`, который должен быть реализован в конкретных подклассах.
- **Concrete Handlers (Конкретные обработчики)**:
  - Классы `DiscountHandler`, `PromotionHandler` и `GiftHandler` являются конкретными обработчиками, реализующими метод `processRequest` для обработки запроса в соответствии с определенными условиями. Каждый из них может либо обработать запрос, либо передать его следующему обработчику в цепочке.
- **OnlineStore (Онлайн-магазин)**:
  - Класс `OnlineStore` представляет основной экран приложения, на котором отображается список продуктов. Для каждого продукта отображается его изображение, название и цена, а также кнопка для покупки.

#### Применение паттерна "Цепочка обязанностей"

Паттерн "Цепочка обязанностей" применяется в данном приложении для реализации логики обработки различных видов скидок и акций в зависимости от цены товара.

- **Разделение логики обработки**:
  - Каждый конкретный обработчик (например, `DiscountHandler`, `PromotionHandler`, `GiftHandler`) отвечает за обработку определенного типа скидки или промоции. Это позволяет разделить общую логику на более мелкие и управляемые части.
- **Динамическое формирование цепочки обработчиков**:
  - В методе `build` класса `OnlineStore` происходит инициализация цепочки обработчиков, где `DiscountHandler` следует за `PromotionHandler`, а `PromotionHandler` следует за `GiftHandler`. Это позволяет легко изменять порядок обработки или добавлять новые обработчики без изменения основного кода.
- **Условное выполнение обработчиков**:
  - При нажатии на кнопку "BUY" для определенного продукта, вызывается метод `handleRequest` у первого обработчика в цепочке (`_discountHandler`). Этот обработчик проверяет, соответствует ли цена продукта условиям для применения скидки. Если условие выполняется, выводится соответствующее сообщение. Затем запрос передается следующему обработчику в цепочке для дополнительной обработки.

#### Заключение

Использование паттерна "Цепочка обязанностей" в данном приложении помогает управлять и расширять логику обработки скидок и акций без создания большого количества условных конструкций. Это делает код более гибким, поддерживаемым и легко расширяемым, что особенно важно для приложений с изменчивой бизнес-логикой, такими как интернет-магазины.

![](https://github.com/xiangxiang3451/blog_pictures/blob/main/image-20240414183510066.png?raw=true)