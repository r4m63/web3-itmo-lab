document.addEventListener('DOMContentLoaded', function () {
    let currentAngle = 0; // Хранение текущего угла вращения

    // Функция для вращения графика
    function rotateSVG() {
        currentAngle += 6; // Поворот на +6 градусов
        applyRotation();
    }

    // Инициализация угла на основе текущего времени
    function initializeRotation() {
        const now = new Date();
        const minutes = now.getMinutes();
        currentAngle = minutes * 6; // Угол на основе минут
        applyRotation(); // Применить сразу, чтобы график отобразился в правильной позиции
    }

    // Применение текущего угла вращения
    function applyRotation() {
        const graphContainer = document.querySelector('[id$="graph-container"]');
        if (graphContainer) {
            graphContainer.style.transform = `rotate(${currentAngle}deg)`;
        }
    }

    // Трансформация координат клика с учётом угла поворота
    function transformCoordinates(x, y) {
        const radians = (currentAngle * Math.PI) / 180; // Перевод угла в радианы
        const transformedX = x * Math.cos(radians) - y * Math.sin(radians);
        const transformedY = x * Math.sin(radians) + y * Math.cos(radians);
        return {x: transformedX, y: transformedY};
    }

    // Обработка кликов по графику
    function handleEvent(e) {
        const graph = document.getElementById('graph');

        // Проверяем, что график существует
        if (!graph) return;

        // Получаем координаты клика относительно графика
        const rect = graph.getBoundingClientRect();
        const svgX = e.clientX - rect.left; // Координаты клика относительно SVG
        const svgY = e.clientY - rect.top;

        // Преобразуем координаты в систему графика с учётом отступов и масштаба
        const x = (svgX - rect.width / 2) / 40; // Преобразование координат в систему графика
        const y = (rect.height / 2 - svgY) / 40;

        // Трансформируем координаты с учётом угла поворота
        const {x: transformedX, y: transformedY} = transformCoordinates(x, y);

        const r = PF('rMenu').getSelectedValue(); // Получение выбранного R из меню

        // Устанавливаем значения в скрытые поля формы
        document.getElementById('hiddenForm:hiddenX').value = transformedX.toFixed(2);
        document.getElementById('hiddenForm:hiddenY').value = transformedY.toFixed(2);
        document.getElementById('hiddenForm:hiddenR').value = r;

        // Отправляем форму
        document.getElementById('hiddenForm:hiddenSubmit').click();

        // Применяем текущий угол вращения, чтобы график не сбрасывался
        applyRotation();
    }

    // Настройка кликов по графику
    function setupClickHandler() {
        const graph = document.getElementById('graph');
        if (graph) {
            graph.removeEventListener('click', handleEvent); // Удаляем предыдущий обработчик
            graph.addEventListener('click', handleEvent); // Добавляем новый обработчик
        }
    }

    // Убедимся, что график готов перед вращением
    function waitForGraphAndRotate() {
        const graphContainer = document.querySelector('[id$="graph-container"]');
        if (graphContainer) {
            initializeRotation(); // Инициализируем вращение
            setupClickHandler(); // Устанавливаем обработчик кликов
        } else {
            // Если график ещё не загружен, пробуем снова через 100 мс
            setTimeout(waitForGraphAndRotate, 100);
        }
    }

    // Инициализация: ждём, пока график станет доступным
    waitForGraphAndRotate();

    // Настройка автоматического вращения графика
    const now = new Date();
    const secondsUntilNextMinute = 60 - now.getSeconds();
    setTimeout(function () {
        rotateSVG(); // Поворот на следующей минуте
        setInterval(rotateSVG, 60000); // Поворот каждую минуту
    }, secondsUntilNextMinute * 1000);
});
