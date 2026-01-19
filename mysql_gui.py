import tkinter as tk
from tkinter import ttk, messagebox
import mysql.connector

TABLE_NAMES_RU = {
    "employees": "Сотрудники",
    "equipment": "Оборудование",
    "filamentdiameters": "Диаметры филамента",
    "packagetypes": "Типы упаковки",
    "packagings": "Упакованное",
    "productcolors": "Цвет продукции",
    "productionprocesses": "Процессы производства",
    "products": "Продукция",
    "qualitycontrols": "Контроль качества",
    "qualitytesttypes": "Типы тестов контроля",
    "rawmaterials": "Сырье",
    "rawmaterialtypes": "Типы сырья",
    "reports": "Отчеты",
    "reporttypes": "Типы отчетов",
    "suppliers": "Поставщики",
    "users": "Пользователи",
    "warehouses": "Склады",
    "warehousestock": "Учет сырья"
}

TABLE_LABELS = {
    "employees": {
        "id": "ID сотрудника",
        "full_name": "ФИО сотрудника",
        "role": "Должность",
        "hire_date": "Принят на работу",
        "is_active": "Статус работника"
    },
    "equipment": {
        "id": "ID оборудования",
        "name": "Наименование оборудования",
        "status": "Статус оборудования",
        "last_maintenance_date": "Дата последнего обсулживания",
        "purchase_date": "Дата покупки"
    },
    "filamentdiameters": {
        "id": "ID филамента",
        "diameter_mm": "Диаметр нити(мм)"
    },
    "packagetypes": {
        "id": "ID упаковки",
        "name": "Наименование упаковки",
        "code": "Код упаковки",
        "length_mm": "Длина(мм)",
        "width_mm": "Ширина(мм)",
        "height_mm": "Высота(мм)",
        "max_weight_kg": "Максимальный вес",
        "is_active": "Статус"
    },
    "packagings": {
        "id": "ID упакованного",
        "package_type_id": "Тип упаковки",
        "quantity": "Количество",
        "packaging_date": "Дата упаковки",
        "product_id": "Тип продукта",
        "employee_id": "Упаковщик",
        "notes": "Описание",
    },
    "productcolors": {
        "id": "ID цвета",
        "name": "Цвет",
        "hex_code": "Код цвета"
    },
    "productionprocesses": {
        "id": "ID процесса",
        "name": "Название процесса",
        "start_time": "Начало процесса",
        "end_time": "Завершение процесса",
        "status": "Статус",
        "equipment_id": "Оборудоание",
        "responsible_employee_id": "Ответственный сотрудник",
        "raw_material_id": "Материал процесса",
        "notes": "Описание"
    },
    "products": {
        "id": "ID продукции",
        "product_type": "Тип продукции",
        "color_id": "Цвет",
        "diameter_id": "Диаметр нити филамента",
        "quantity_kg": "Количество(кг)",
        "production_date": "Дата изготовления",
        "process_id": "Процесс",
        "batch_number": "Номер партии"
    },
    "qualitycontrols": {
        "id": "ID проверки",
        "test_type_id": "Тип проверки",
        "test_date": "Дата проверки",
        "result_value": "Результат",
        "passed": "Пройден/не пройден (1-пройден, 0 - нет)",
        "notes": "Описание",
        "product_id": "Тип продукции",
        "employee_id": "Ответственный сотрудник"
    },
    "qualitytesttypes": {
        "id": "ID типа проверки",
        "name": "Тип проверки",
        "code": "Код типа",
        "unit": "Единица измерения"
    },
    "rawmaterials": {
        "id": "ID материала",
        "material_type_id": "Тип материала",
        "quantity_kg": "Количество",
        "received_date": "Дата поставки",
        "supplier_id": "Поставщик",
        "quality_grade": "Оценка качества",
        "batch_number": "Номер партии",
        "created_at": "Сделано",
        "price_total": "Стоимость"
    },
    "rawmaterialtypes": {
        "id": "ID типа материала",
        "name": "Тип материала",
        "code": "Код материала",
        "description": "Описание"
    },
    "reports": {
        "id": "ID отчета",
        "report_type_id": "Тип отчета",
        "generated_at": "Сгенерирован",
        "period_start": "Период(начало)",
        "period_end": "Период(конец)",
        "content": "Описание",
        "file_path": "Путь к файлу",
        "generated_by_employee_id": "Сгенерирован сотрудником"
    },
    "reporttypes": {
        "id": "ID типа отчета",
        "name": "Тип отчета",
        "code": "Код отчета",
        "description": "Описание",
        "is_active": "Статус",
        "created_at": "Сделан"
    },
    "suppliers": {
        "id": "ID поставщика",
        "name": "Поставщик",
        "contact_info": "Контакт поставщика",
        "created_at": "Работает с"
    },
    "users": {
        "id": "ID пользователя",
        "username": "Пользователь",
        "password_hash": "Пароль",
        "role": "Роль",
        "created_at": "Зарегистрирован",
        "is_active": "Статус"
    },
    "warehouses": {
        "id": "ID склада",
        "location": "Локация",
        "capacity_kg": "Вместимость(кг)",
        "current_stock_kg": "Текущий запас(кг)"
    },
    "warehousestock": {
        "id": "ID",
        "warehouse_id": "Склад",
        "product_id": "Продукция",
        "quantity_kg": "Количество",
        "last_updated": "Последнее обновление"
    }
}

FOREIGN_KEYS = {
    # ================== УПАКОВКА ==================
    "packagings": {
        "package_type_id": ("packagetypes", "id", "name"),
        "product_id": ("products", "id", "product_type"),
        "employee_id": ("employees", "id", "full_name"),
    },

    # ================== ПРОДУКЦИЯ ==================
    "products": {
        "color_id": ("productcolors", "id", "name"),
        "diameter_id": ("filamentdiameters", "id", "diameter_mm"),
        "process_id": ("productionprocesses", "id", "name"),
    },

    # ================== ПРОИЗВОДСТВЕННЫЕ ПРОЦЕССЫ ==================
    "productionprocesses": {
        "equipment_id": ("equipment", "id", "name"),
        "responsible_employee_id": ("employees", "id", "full_name"),
        "raw_material_id": ("rawmaterials", "id", "batch_number"),
    },

    # ================== СЫРЬЁ ==================
    "rawmaterials": {
        "material_type_id": ("rawmaterialtypes", "id", "name"),
        "supplier_id": ("suppliers", "id", "name"),
    },

    # ================== КОНТРОЛЬ КАЧЕСТВА ==================
    "qualitycontrols": {
        "test_type_id": ("qualitytesttypes", "id", "name"),
        "product_id": ("products", "id", "product_type"),
        "employee_id": ("employees", "id", "full_name"),
    },

    # ================== ОТЧЁТЫ ==================
    "reports": {
        "report_type_id": ("reporttypes", "id", "name"),
        "generated_by_employee_id": ("employees", "id", "full_name"),
    },

    # ================== СКЛАД ==================
    "warehousestock": {
        "warehouse_id": ("warehouses", "id", "location"),
        "product_id": ("products", "id", "product_type"),
    },
}


PARAMETER_NAMES_RU = {
    # Общие
    "raw_id": "Идентификатор",
    "name": "Название",
    "quantity": "Количество",
    "amount": "Сумма",
    "price": "Цена",
    "date": "Дата",
    "p_product_type": "Тип продукта",
    "p_color_id": "ID цвета",
    "p_diameter_id": "ID диаметра",
    "p_quantity_kg": "Количество",
    "p_batch_number": "Номер батча",
    "p_package_type_id": "ID Типа упаковки",
    "p_notes": "Заметки",

    # Для процедур / функций
    "material_id": "Материал",
    "product_id": "ID продукта",
    "supplier_id": "Поставщик",
    "process_id": "Процесс",
    "user_id": "Пользователь",
    "p_package_type": "Тип упаковки",
    "p_employee_id": "Сборщик",
    "p_notes": "Описание",

    "start_date": "Дата начала",
    "end_date": "Дата окончания",

    "from_date": "Дата с",
    "to_date": "Дата по",

    "count_value": "Количество",
    "output_value": "Объём выпуска"
}

ROUTINE_NAMES_RU = {
    # Функции
    "days_until_rawmaterial_runs_out": "Расчет дней до истощения сырья",
    "quality_passed": "Контроль качества",
    "rawmaterial_used_kg": "Расчет использования сырья",
    "finish_production_process": "Завершение производственного процесса",

    # Процедуры
    "pack_product": "Упаковка продукта",
    "stock_report": "Отчетность",
    "add_material": "Добавить материал",
    "start_process": "Запуск производственного процесса",
    "finish_process": "Завершение производственного процесса",
}

COLUMN_HINTS = {
    "int": "Введите целое число",
    "float": "Введите число (например 12.5)",
    "varchar": "Введите текст",
    "text": "Введите текст",
    "date": "Формат: ГГГГ-ММ-ДД",
    "datetime": "Формат: ГГГГ-ММ-ДД ЧЧ:ММ:СС",
    "boolean": "0 — нет, 1 — да"
}


def detect_foreign_key(connection, table_name, column_name):
    """
    Автоматически определяет FK по имени *_id
    Возвращает (ref_table, id_col, label_col) или None
    """
    if not column_name.lower().endswith("_id"):
        return None

    base = column_name[:-3]  # employee_id → employee
    candidates = [
        base + "s",
        base + "es",
        base
    ]

    cursor = connection.cursor()

    for ref_table in candidates:
        try:
            cursor.execute(f"SHOW TABLES LIKE %s", (ref_table,))
            if not cursor.fetchone():
                continue

            cursor.execute(f"DESCRIBE `{ref_table}`")
            columns = [row[0] for row in cursor.fetchall()]

            for label_col in ("name", "full_name", "title"):
                if label_col in columns:
                    return (ref_table, "id", label_col)

        except Exception:
            continue

    return None

def get_foreign_key_info(connection, table_name, column_name):
    """
    Возвращает описание FK:
    (ref_table, id_col, label_col) или None
    """
    # 1. Явно заданные связи
    table_fks = FOREIGN_KEYS.get(table_name, {})
    if column_name in table_fks:
        return table_fks[column_name]

    # 2. Автоопределение
    return detect_foreign_key(connection, table_name, column_name)


def get_column_label(table_name: str, column_name: str) -> str:
    """
    Возвращает русское название столбца из TABLE_LABELS
    """
    table_key = table_name.lower()
    column_key = column_name.lower()

    return (
        TABLE_LABELS
        .get(table_key, {})
        .get(column_key, column_name)
    )


def translate_param_name(param_name: str) -> str:
    """
    Переводит имя параметра в читаемый вид
    """
    if not param_name:
        return ""

    clean = param_name.lower()

    # убираем типичные префиксы
    for prefix in ("in_", "p_", "param_", "v_"):
        if clean.startswith(prefix):
            clean = clean[len(prefix):]

    return PARAMETER_NAMES_RU.get(clean, param_name)

def translate_routine_name(routine_name: str) -> str:
    """
    Переводит имя функции / процедуры для отображения в UI
    """
    if not routine_name:
        return ""

    key = routine_name.lower()
    return ROUTINE_NAMES_RU.get(key, routine_name)

def apply_pink_theme(root):
    style = ttk.Style(root)
    style.theme_use("default")

    root.configure(bg="#fde2e4")

    style.configure(
        "Pink.TFrame",
        background="#fadadd"
    )

    style.configure(
        "Pink.TButton",
        background="#f497b6",
        foreground="#4a2c2a",
        font=("Segoe UI", 10, "bold"),
        padding=6
    )

    style.map(
        "Pink.TButton",
        background=[("active", "#f080a0")]
    )

    style.configure(
        "Pink.Treeview",
        background="white",
        fieldbackground="white",
        foreground="#4a2c2a",
        rowheight=24
    )

    style.configure(
        "Pink.Treeview.Heading",
        background="#f497b6",
        foreground="white",
        font=("Segoe UI", 10, "bold")
    )
import re

def validate_datetime(value: str, column_type: str):
    """
    Проверяет корректность DATE / DATETIME
    """
    if not value:
        return True  # пусто → допустим, обработается как NULL

    if "date" in column_type and "time" not in column_type:
        # DATE → YYYY-MM-DD
        return bool(re.match(r"^\d{4}-\d{2}-\d{2}$", value))

    if "datetime" in column_type:
        # DATETIME → YYYY-MM-DD HH:MM:SS
        return bool(re.match(r"^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$", value))

    return True

def validate_numeric(value: str, column_type: str):
    """
    Проверка числовых типов
    """
    if value is None or value == "":
        return True  # NULL допустим

    try:
        if "int" in column_type:
            int(value)
        elif "float" in column_type or "decimal" in column_type:
            float(value)
        elif "boolean" in column_type:
            if value not in ("0", "1"):
                return False
        return True
    except ValueError:
        return False

def validate_non_negative(value: str, column_type: str) -> bool:
    """
    Проверка, что числовое значение >= 0
    """
    if value is None or value == "":
        return True  # NULL допустим

    try:
        if "int" in column_type or "float" in column_type or "decimal" in column_type:
            return float(value) >= 0

        if "boolean" in column_type:
            return value in ("0", "1")

        return True
    except ValueError:
        return False


def handle_error(e, title="Ошибка"):
    if isinstance(e, mysql.connector.Error):

        msg = e.msg.lower()

        # 🔴 выход за диапазон
        if "out of range" in msg:
            messagebox.showerror(
                title,
                "Введено слишком большое или недопустимое число.\n"
                "Проверьте диапазон значения."
            )
            return

        # 🔴 неверный тип
        if "incorrect" in msg or "truncated" in msg:
            messagebox.showerror(
                title,
                "Неверный формат данных.\n"
                "Проверьте ввод."
            )
            return

        messagebox.showerror(title, f"Ошибка базы данных:\n{e.msg}")

    elif isinstance(e, ValueError):
        messagebox.showerror(title, f"Ошибка данных:\n{str(e)}")

    else:
        messagebox.showerror(title, f"Непредвиденная ошибка:\n{str(e)}")

def handle_delete_fk_error(e, table_name):
    """
    Обработка ошибки удаления записи,
    на которую есть внешние ключи
    """
    if isinstance(e, mysql.connector.Error):
        if e.errno == 1451:  # MySQL FK constraint
            messagebox.showerror(
                "Невозможно удалить запись",
                "Эта запись используется в других таблицах.\n\n"
                "Сначала удалите или измените связанные записи."
            )
            return True
    return False


def safe_execute(cursor, sql, params=None, title="Ошибка SQL"):
    try:
        if params:
            cursor.execute(sql, params)
        else:
            cursor.execute(sql)
        return True
    except Exception as e:
        handle_error(e, title)
        return False


# ================== ОКНО АВТОРИЗАЦИИ ==================
class LoginWindow:
    def __init__(self, root):
        self.root = root
        self.root.title("Авторизация MySQL")
        self.root.geometry("300x230")
        self.root.configure(bg="#fde2e4")

        frame = ttk.Frame(root, style="Pink.TFrame")
        frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

        tk.Label(frame, text="Хост", bg="#fadadd").pack()
        self.host = tk.Entry(frame)
        self.host.insert(0, "localhost")
        self.host.pack(fill=tk.X)

        tk.Label(frame, text="Пользователь", bg="#fadadd").pack()
        self.user = tk.Entry(frame)
        self.user.insert(0, "root")
        self.user.pack(fill=tk.X)

        tk.Label(frame, text="Пароль", bg="#fadadd").pack()
        self.password = tk.Entry(frame, show="*")
        self.password.insert(0, "root312")
        self.password.pack(fill=tk.X)

        tk.Label(frame, text="База данных", bg="#fadadd").pack()
        self.database = tk.Entry(frame)
        self.database.insert(0, "filament_factory")
        self.database.pack(fill=tk.X)

        ttk.Button(
            frame,
            text="Войти",
            style="Pink.TButton",
            command=self.login
        ).pack(pady=10)

    def login(self):
        try:
            connection = mysql.connector.connect(
                host=self.host.get(),
                user=self.user.get(),
                password=self.password.get(),
                database=self.database.get()
            )
            messagebox.showinfo("Успех", "Подключение выполнено")
            self.root.withdraw()
            TablesWindow(self.root, connection)

        except mysql.connector.Error as e:
            messagebox.showerror("Ошибка подключения", str(e))

class ProceduresWindow:
    def __init__(self, parent, connection):
        self.connection = connection

        self.window = tk.Toplevel(parent)
        self.window.title("Хранимые процедуры")
        self.window.geometry("700x400")
        self.window.configure(bg="#fde2e4")

        frame = ttk.Frame(self.window, style="Pink.TFrame")
        frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

        tk.Label(frame, text="Список процедур", bg="#fadadd").pack(pady=5)

        self.listbox = tk.Listbox(frame)
        self.listbox.pack(fill=tk.BOTH, expand=True, pady=5)

        ttk.Button(
            frame,
            text="▶ Выполнить процедуру",
            style="Pink.TButton",
            command=self.execute_procedure
        ).pack(pady=5)

        self.load_procedures()

    # ===== ЗАГРУЗКА ПРОЦЕДУР =====
    def load_procedures(self):
        cursor = self.connection.cursor()
        cursor.execute("""
            SELECT routine_name
            FROM information_schema.routines
            WHERE routine_schema = DATABASE()
              AND routine_type = 'PROCEDURE'
        """)

        for (proc_name,) in cursor.fetchall():
            self.listbox.insert(tk.END, proc_name)

    # ===== ВЫПОЛНЕНИЕ ПРОЦЕДУРЫ =====
    def execute_procedure(self):
        if not self.listbox.curselection():
            messagebox.showwarning("Ошибка", "Выберите процедуру")
            return

        proc_name = self.listbox.get(self.listbox.curselection())

        try:
            cursor = self.connection.cursor()
            cursor.callproc(proc_name)

            # Если процедура возвращает результат
            for result in cursor.stored_results():
                rows = result.fetchall()
                if rows:
                    self.show_result(rows, result.column_names)

            self.connection.commit()
            messagebox.showinfo("Успех", f"Процедура «{proc_name}» выполнена")

        except Exception as e:
            messagebox.showerror("Ошибка", str(e))

    # ===== ОТОБРАЖЕНИЕ РЕЗУЛЬТАТА =====
    def show_result(self, rows, columns):
        win = tk.Toplevel(self.window)
        win.title("Результат процедуры")
        win.geometry("700x400")
        win.configure(bg="#fde2e4")

        tree = ttk.Treeview(
            win,
            columns=columns,
            show="headings",
            style="Pink.Treeview"
        )
        tree.pack(fill=tk.BOTH, expand=True)

        for col in columns:
            tree.heading(col, text=col)
            tree.column(col, width=120)

        lookups = {}

        for col in columns:
            if "_" in col:
                table, column = col.split("_", 1)
                fk = get_foreign_key_info(self.connection, table, column)
                if fk:
                    ref_table, ref_id, ref_label = fk
                    cur = self.connection.cursor()
                    cur.execute(f"SELECT {ref_id}, {ref_label} FROM `{ref_table}`")
                    lookups[col] = {str(i): str(v) for i, v in cur.fetchall()}

        for row in rows:
            display_row = []
            for col, val in zip(columns, row):
                if col in lookups and val is not None:
                    display_row.append(lookups[col].get(str(val), val))
                else:
                    display_row.append(val)

            tree.insert("", tk.END, values=display_row)


class RoutinesWindow:
    def __init__(self, parent, connection):
        self.connection = connection

        self.window = tk.Toplevel(parent)
        self.window.title("Процедуры и функции")
        self.window.geometry("500x450")
        self.window.configure(bg="#fde2e4")

        frame = ttk.Frame(self.window, style="Pink.TFrame")
        frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

        tk.Label(frame, text="Процедуры и функции", bg="#fadadd").pack(pady=5)

        self.listbox = tk.Listbox(frame)
        self.listbox.pack(fill=tk.BOTH, expand=True)

        ttk.Button(
            frame,
            text="▶ Выполнить",
            style="Pink.TButton",
            command=self.open_parameters_window
        ).pack(pady=5)

        self.load_routines()
    def load_routines(self):
        self.routines = {}

        cursor = self.connection.cursor()
        cursor.execute("""
            SELECT routine_name, routine_type
            FROM information_schema.routines
            WHERE routine_schema = DATABASE()
        """)

        for name, rtype in cursor.fetchall():
            if name == "stock_report":
                continue  # ❌ убираем отчетность

            translated = translate_routine_name(name)
            display = f"{translated} ({rtype.lower()})"

            self.listbox.insert(tk.END, display)
            self.routines[display] = (name, rtype)

    def open_parameters_window(self):
        if not self.listbox.curselection():
            messagebox.showwarning("Ошибка", "Выберите процедуру или функцию")
            return

        display = self.listbox.get(self.listbox.curselection())
        name, rtype = self.routines[display]

        cursor = self.connection.cursor()
        if rtype == "PROCEDURE":
            cursor.execute("""
                SELECT parameter_name
                FROM information_schema.parameters
                WHERE specific_schema = DATABASE()
                  AND specific_name = %s
                  AND parameter_mode IN ('IN', 'INOUT')
                ORDER BY ordinal_position
            """, (name,))
        else:  # FUNCTION
            cursor.execute("""
                SELECT parameter_name
                FROM information_schema.parameters
                WHERE specific_schema = DATABASE()
                  AND specific_name = %s
                  AND parameter_mode = 'IN'
                ORDER BY ordinal_position
            """, (name,))

        params = [p[0] for p in cursor.fetchall()]

        self.show_parameters_form(name, rtype, params)
    def show_parameters_form(self, name, rtype, params):
        win = tk.Toplevel(self.window)
        win.title(f"Параметры: {name}")
        win.configure(bg="#fde2e4")

        frame = ttk.Frame(win, style="Pink.TFrame")
        frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

        entries = {}

        if not params:
            tk.Label(frame, text="Параметров нет", bg="#fadadd").pack()
        else:
            for p in params:
                label_text = translate_param_name(p)

                tk.Label(
                    frame,
                    text=label_text,
                    bg="#fadadd"
                ).pack(anchor="w", pady=2)

                e = tk.Entry(frame)
                e.pack(fill=tk.X, pady=2)

                entries[p] = e  # ⚠️ ключ — ОРИГИНАЛЬНОЕ имя

        def execute():
            values = [e.get() for e in entries.values()]
            cursor = self.connection.cursor()

            try:
                if rtype == "PROCEDURE":
                    placeholders = ", ".join(["%s"] * len(values))
                    cursor.execute(f"CALL {name}({placeholders})", values)

                    for result in cursor.stored_results():
                        rows = result.fetchall()
                        if rows:
                            self.show_result(rows, result.column_names)

                else:  # FUNCTION
                    placeholders = ", ".join(["%s"] * len(values))
                    cursor.execute(
                        f"SELECT {name}({placeholders}) AS result",
                        values
                    )
                    rows = cursor.fetchall()
                    self.show_result(rows, ["result"])

                self.connection.commit()
                win.destroy()

            except Exception as e:
                messagebox.showerror("Ошибка", str(e))

        ttk.Button(
            frame,
            text="Выполнить",
            style="Pink.TButton",
            command=execute
        ).pack(pady=10)
    def show_result(self, rows, columns):
        win = tk.Toplevel(self.window)
        win.title("Результат")
        win.geometry("600x400")
        win.configure(bg="#fde2e4")

        tree = ttk.Treeview(
            win,
            columns=columns,
            show="headings",
            style="Pink.Treeview"
        )
        tree.pack(fill=tk.BOTH, expand=True)

        for col in columns:
            tree.heading(col, text=col)
            tree.column(col, width=150)

        for row in rows:
            tree.insert("", tk.END, values=row)

class JoinWindow:
    def __init__(self, parent, connection):
        self.connection = connection

        self.window = tk.Toplevel(parent)
        self.window.title("Объединение таблиц (JOIN)")
        self.window.geometry("500x400")
        self.window.configure(bg="#fde2e4")

        frame = ttk.Frame(self.window, style="Pink.TFrame")
        frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

        cursor = self.connection.cursor()
        cursor.execute("SHOW TABLES")
        self.table_map = {}  # русское → реальное
        display_tables = []

        for (table_name,) in cursor.fetchall():
            display = TABLE_NAMES_RU.get(table_name, table_name)
            self.table_map[display] = table_name
            display_tables.append(display)

        # ---------- Таблица 1 ----------
        tk.Label(frame, text="Первая таблица", bg="#fadadd").pack(anchor="w")
        self.table1_var = tk.StringVar()
        self.table1_combo = ttk.Combobox(
            frame, textvariable=self.table1_var, values=display_tables, state="readonly"
        )
        self.table1_combo.pack(fill=tk.X)
        self.table1_combo.bind("<<ComboboxSelected>>", self.load_columns_1)

        tk.Label(frame, text="Столбец первой таблицы", bg="#fadadd").pack(anchor="w")
        self.column1_var = tk.StringVar()
        self.column1_combo = ttk.Combobox(
            frame, textvariable=self.column1_var, state="readonly"
        )
        self.column1_combo.pack(fill=tk.X)

        # ---------- Таблица 2 ----------
        tk.Label(frame, text="Вторая таблица", bg="#fadadd").pack(anchor="w", pady=(10,0))
        self.table2_var = tk.StringVar()
        self.table2_combo = ttk.Combobox(
            frame, textvariable=self.table2_var, values=display_tables, state="readonly"
        )
        self.table2_combo.pack(fill=tk.X)
        self.table2_combo.bind("<<ComboboxSelected>>", self.load_columns_2)

        tk.Label(frame, text="Столбец второй таблицы", bg="#fadadd").pack(anchor="w")
        self.column2_var = tk.StringVar()
        self.column2_combo = ttk.Combobox(
            frame, textvariable=self.column2_var, state="readonly"
        )
        self.column2_combo.pack(fill=tk.X)

        # ---------- Тип JOIN ----------
        tk.Label(frame, text="Тип объединения", bg="#fadadd").pack(anchor="w", pady=(10,0))
        self.join_type_var = tk.StringVar(value="INNER")
        self.join_type_combo = ttk.Combobox(
            frame,
            textvariable=self.join_type_var,
            values=["INNER", "LEFT", "RIGHT"],
            state="readonly"
        )
        self.join_type_combo.pack(fill=tk.X)

        # ---------- Кнопка ----------
        ttk.Button(
            frame,
            text="Выполнить JOIN",
            style="Pink.TButton",
            command=self.execute_join
        ).pack(pady=15)

    def load_columns_1(self, event):
        cols, self.column1_map = self.get_columns(self.table1_var.get())
        self.column1_combo["values"] = cols
        self.column1_combo.current(0)

    def load_columns_2(self, event):
        cols, self.column2_map = self.get_columns(self.table2_var.get())
        self.column2_combo["values"] = cols
        self.column2_combo.current(0)

    def get_columns(self, table_display):
        table_real = self.table_map[table_display]

        cursor = self.connection.cursor()
        cursor.execute(f"DESCRIBE {table_real}")

        column_map = {}  # русское → реальное
        display_columns = []

        for (col_name, *_) in cursor.fetchall():
            display = get_column_label(table_real, col_name)
            column_map[display] = col_name
            display_columns.append(display)

        return display_columns, column_map

    def execute_join(self):
        t1_display = self.table1_var.get()
        t2_display = self.table2_var.get()
        c1_display = self.column1_var.get()
        c2_display = self.column2_var.get()

        # ❌ Нельзя объединять одну и ту же таблицу
        if t1_display == t2_display:
            messagebox.showerror(
                "Ошибка объединения",
                "Нельзя объединять одну и ту же таблицу.\n"
                "Выберите две разные таблицы."
            )
            return

        if not all([t1_display, t2_display, c1_display, c2_display]):
            messagebox.showwarning("Ошибка", "Заполните все поля")
            return

        t1 = self.table_map[t1_display]
        t2 = self.table_map[t2_display]
        c1 = self.column1_map[c1_display]
        c2 = self.column2_map[c2_display]

        join_type = self.join_type_var.get()

        cursor = self.connection.cursor()

        # --- проверяем FK ---
        fk1 = get_foreign_key_info(self.connection, t1, c1)
        fk2 = get_foreign_key_info(self.connection, t2, c2)

        select_parts = []
        join_parts = []
        used_tables = set([t1, t2])

        # ---- левая часть ----
        if fk1:
            ref_table, ref_id, ref_label = fk1
            alias = f"{ref_table}_lbl"
            join_parts.append(
                f"LEFT JOIN {ref_table} {alias} ON {t1}.{c1} = {alias}.{ref_id}"
            )
            select_parts.append(
                f"{alias}.{ref_label} AS {t1}_{c1}"
            )
            used_tables.add(ref_table)
        else:
            select_parts.append(f"{t1}.{c1} AS {t1}_{c1}")

        # ---- правая часть ----
        if fk2:
            ref_table, ref_id, ref_label = fk2
            alias = f"{ref_table}_lbl"
            if ref_table not in used_tables:
                join_parts.append(
                    f"LEFT JOIN {ref_table} {alias} ON {t2}.{c2} = {alias}.{ref_id}"
                )
            select_parts.append(
                f"{alias}.{ref_label} AS {t2}_{c2}"
            )
        else:
            select_parts.append(f"{t2}.{c2} AS {t2}_{c2}")

        sql = f"""
            SELECT {", ".join(select_parts)}
            FROM {t1}
            {join_type} JOIN {t2}
                ON {t1}.{c1} = {t2}.{c2}
            {" ".join(join_parts)}
        """

        try:
            cursor.execute(sql)
            rows = cursor.fetchall()
            columns = cursor.column_names
            self.show_result(rows, columns)
        except Exception as e:
            handle_error(e, "Ошибка JOIN")

    def show_result(self, rows, columns):
        win = tk.Toplevel(self.window)
        win.title("Результат JOIN")
        win.geometry("900x500")
        win.configure(bg="#fde2e4")

        tree = ttk.Treeview(
            win,
            columns=columns,
            show="headings",
            style="Pink.Treeview"
        )
        tree.pack(fill=tk.BOTH, expand=True)

        for col in columns:
            label = col

            if "_" in col:
                table, column = col.split("_", 1)
                label = get_column_label(table, column)

            tree.heading(col, text=label)
            tree.column(col, width=140)

        for row in rows:
            tree.insert("", tk.END, values=row)


# ================== ОКНО СПИСКА ТАБЛИЦ ==================
class TablesWindow:
    def __init__(self, root, connection, search_query=None):
        self.connection = connection
        self.search_query = search_query
        self.window = tk.Toplevel(root)
        self.window.title("Таблицы БД")
        self.window.geometry("600x500")
        self.window.configure(bg="#fde2e4")

        top = ttk.Frame(self.window, style="Pink.TFrame")
        top.pack(fill=tk.X, padx=5, pady=5)


        ttk.Button(
            top, text="➕ Создать таблицу",
            style="Pink.TButton",
            command=self.create_table
        ).pack(side=tk.LEFT, padx=5)

        ttk.Button(
            top, text="❌ Удалить таблицу",
            style="Pink.TButton",
            command=self.delete_table
        ).pack(side=tk.LEFT, padx=5)
        ttk.Button(
            top,
            text="⚙ Процедуры и функции",
            style="Pink.TButton",
            command=self.open_routines_window
        ).pack(side=tk.LEFT, padx=5)

        ttk.Button(
            top,
            text="🔗 Объединить таблицы (JOIN)",
            style="Pink.TButton",
            command=self.open_join_window
        ).pack(side=tk.LEFT, padx=5)

        search_frame = ttk.Frame(self.window, style="Pink.TFrame")
        search_frame.pack(fill=tk.X, padx=5, pady=5)

        # ---- Выпадающий список таблиц ----
        tk.Label(search_frame, text="Таблица:", bg="#fadadd").pack(side=tk.LEFT, padx=5)

        self.search_table_var = tk.StringVar()
        self.search_table_combo = ttk.Combobox(
            search_frame,
            textvariable=self.search_table_var,
            state="readonly"
        )
        self.search_table_combo.pack(side=tk.LEFT, padx=5)

        # ---- Поле поиска ----
        tk.Label(search_frame, text="Поиск:", bg="#fadadd").pack(side=tk.LEFT, padx=5)

        self.search_text_var = tk.StringVar()
        search_entry = tk.Entry(search_frame, textvariable=self.search_text_var)
        search_entry.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=5)

        # ---- Кнопка ----
        ttk.Button(
            search_frame,
            text="🔍 Найти",
            style="Pink.TButton",
            command=self.search_in_table
        ).pack(side=tk.LEFT, padx=5)

        self.listbox = tk.Listbox(self.window)
        self.listbox.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        self.listbox.bind("<Double-Button-1>", self.open_table)

        self.load_tables()

    def open_join_window(self):
        JoinWindow(self.window, self.connection)

    def show_global_search_results(self, results):
        win = tk.Toplevel(self.window)
        win.title("Результаты поиска по всем таблицам")
        win.geometry("900x500")
        win.configure(bg="#fde2e4")

        notebook = ttk.Notebook(win)
        notebook.pack(fill=tk.BOTH, expand=True)

        for table_display, columns, rows in results:
            frame = ttk.Frame(notebook)
            notebook.add(frame, text=table_display)

            tree = ttk.Treeview(
                frame,
                columns=columns,
                show="headings",
                style="Pink.Treeview"
            )
            tree.pack(fill=tk.BOTH, expand=True)

            for col in columns:
                tree.heading(col, text=col)
                tree.column(col, width=120)

            for row in rows:
                tree.insert("", tk.END, values=row)

    def search_in_table(self):
        query = self.search_text_var.get().strip()
        selected = self.search_table_var.get()

        if not query:
            messagebox.showwarning("Ошибка", "Введите текст для поиска")
            return

        cursor = self.connection.cursor()

        # ===== ПОИСК В ОДНОЙ ТАБЛИЦЕ =====
        if selected != "Все таблицы":
            table_name = self.table_map[selected]

            TableDataWindow(
                self.window,
                self.connection,
                table_name,
                search_query=query
            )
            return

        # ===== ПОИСК ПО ВСЕМ ТАБЛИЦАМ =====
        results = []

        for display, table_name in self.table_map.items():
            cursor.execute(f"DESCRIBE {table_name}")
            columns = [c[0] for c in cursor.fetchall()]

            conditions = " OR ".join([f"{col} LIKE %s" for col in columns])
            values = [f"%{query}%"] * len(columns)

            sql = f"SELECT * FROM {table_name} WHERE {conditions}"
            cursor.execute(sql, values)

            rows = cursor.fetchall()
            if rows:
                results.append((display, columns, rows))

        if not results:
            messagebox.showinfo("Результат", "Ничего не найдено")
            return

        # показываем результаты
        self.show_global_search_results(results)

    def update_table_list(self, tables):
        self.listbox.delete(0, tk.END)
        for name in tables:
            self.listbox.insert(tk.END, name)

    def filter_tables(self, *args):
        query = self.filter_var.get().lower()
        if not query:
            self.update_table_list(self.all_tables)
            return

        filtered = [t for t in self.all_tables if query in t.lower()]
        self.update_table_list(filtered)

    def open_routines_window(self):
        RoutinesWindow(self.window, self.connection)

    def load_tables(self):
        self.listbox.delete(0, tk.END)
        self.table_map = {}

        cursor = self.connection.cursor()
        cursor.execute("SHOW TABLES")

        display_names = []

        for (table_name,) in cursor.fetchall():
            display = TABLE_NAMES_RU.get(table_name, table_name)

            self.listbox.insert(tk.END, display)
            self.table_map[display] = table_name
            display_names.append(display)

        # ⬇️ ВАЖНО: добавляем "Все таблицы"
        self.search_table_combo["values"] = ["Все таблицы"] + display_names
        self.search_table_combo.current(0)

    def open_table(self, event):
        if not self.listbox.curselection():
            return
        display_name = self.listbox.get(self.listbox.curselection())
        real_name = self.table_map[display_name]

        TableDataWindow(self.window, self.connection, real_name)

    def create_table(self):
        win = tk.Toplevel(self.window)
        win.title("Создание таблицы")
        win.configure(bg="#fde2e4")

        frame = ttk.Frame(win, style="Pink.TFrame")
        frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

        tk.Label(frame, text="Имя таблицы", bg="#fadadd").pack()
        name_entry = tk.Entry(frame)
        name_entry.pack(fill=tk.X)

        def create():
            name = name_entry.get().strip()

            if not name:
                messagebox.showwarning("Ошибка", "Введите имя таблицы")
                return

            try:
                cursor = self.connection.cursor()
                sql = f"""
                CREATE TABLE `{name}` (
                    id INT AUTO_INCREMENT PRIMARY KEY
                )
                """

                if not safe_execute(cursor, sql, title="Создание таблицы"):
                    return

                self.connection.commit()

                messagebox.showinfo("Успех", f"Таблица «{name}» создана")
                win.destroy()
                self.load_tables()

            except Exception as e:
                messagebox.showerror("Ошибка", str(e))

        ttk.Button(
            frame, text="Создать",
            style="Pink.TButton",
            command=create
        ).pack(pady=5)

    def delete_table(self):
        # Проверяем, выбрана ли таблица
        if not self.listbox.curselection():
            messagebox.showwarning("Ошибка", "Выберите таблицу для удаления")
            return

        # Отображаемое (русское) имя
        display_name = self.listbox.get(self.listbox.curselection())

        # Реальное имя таблицы в БД
        table_name = self.table_map[display_name]

        # Подтверждение удаления
        if not messagebox.askyesno(
                "Подтверждение",
                f"Вы действительно хотите удалить таблицу «{display_name}»?"
        ):
            return

        try:
            cursor = self.connection.cursor()
            cursor.execute(f"DROP TABLE `{table_name}`")
            self.connection.commit()

            messagebox.showinfo("Успешно", f"Таблица «{display_name}» удалена")
            self.load_tables()

        except Exception as e:
            messagebox.showerror("Ошибка удаления", str(e))

    def open_procedures_window(self):
        ProceduresWindow(self.window, self.connection)

# ================== ОКНО ДАННЫХ ТАБЛИЦЫ ==================
class TableDataWindow:
    def __init__(self, parent, connection, table_name, search_query=None):
        self.connection = connection
        self.table_name = table_name
        self.search_query = search_query

        self.window = tk.Toplevel(parent)
        self.window.title(f"Таблица: {table_name}")
        self.window.geometry("900x500")
        self.window.configure(bg="#fde2e4")

        # ✅ 1. СНАЧАЛА создаём top
        top = ttk.Frame(self.window, style="Pink.TFrame")
        top.pack(fill=tk.X, padx=5, pady=5)

        ttk.Button(
            top,
            text="🧩 Структура таблицы",
            style="Pink.TButton",
            command=self.open_structure_editor
        ).pack(side=tk.LEFT, padx=5)

        # ✅ 2. КНОПКИ CRUD
        ttk.Button(top, text="➕ Добавить", style="Pink.TButton", command=self.add_row)\
            .pack(side=tk.LEFT, padx=5)

        ttk.Button(top, text="✏ Редактировать", style="Pink.TButton", command=self.edit_row)\
            .pack(side=tk.LEFT, padx=5)

        ttk.Button(top, text="❌ Удалить", style="Pink.TButton", command=self.delete_row)\
            .pack(side=tk.LEFT, padx=5)

        # ✅ 3. ПЕРЕМЕННЫЕ СОРТИРОВКИ
        tk.Label(top, text="Сортировка:", bg="#fadadd")\
            .pack(side=tk.LEFT, padx=5)

        self.sort_column_var = tk.StringVar()

        # ✅ 4. Combobox — ТЕПЕРЬ top СУЩЕСТВУЕТ
        self.sort_column_combo = ttk.Combobox(
            top,
            textvariable=self.sort_column_var,
            state="readonly",
            width=18
        )
        self.sort_column_combo.pack(side=tk.LEFT, padx=5)

        self.sort_order = "ASC"

        ttk.Button(
            top,
            text="🔃 Сортировать",
            style="Pink.TButton",
            command=self.sort_data
        ).pack(side=tk.LEFT, padx=5)

        # ✅ 5. Таблица
        self.tree = ttk.Treeview(
            self.window,
            show="headings",
            style="Pink.Treeview"
        )
        self.tree.pack(fill=tk.BOTH, expand=True)

        # ✅ 6. Загружаем данные
        self.load_data()

        search_frame = ttk.Frame(self.window, style="Pink.TFrame")
        search_frame.pack(fill=tk.X, padx=5, pady=5)

        tk.Label(search_frame, text="Поиск:", bg="#fadadd").pack(side=tk.LEFT, padx=5)

        self.search_var = tk.StringVar()
        search_entry = tk.Entry(search_frame, textvariable=self.search_var)
        search_entry.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=5)

        ttk.Button(
            search_frame,
            text="Найти",
            style="Pink.TButton",
            command=self.search_data
        ).pack(side=tk.LEFT, padx=5)

        ttk.Button(
            search_frame,
            text="Сброс",
            style="Pink.TButton",
            command=self.load_data
        ).pack(side=tk.LEFT, padx=5)

    def open_structure_editor(self):
        win = tk.Toplevel(self.window)
        win.title("Редактор структуры таблицы")
        win.geometry("500x400")
        win.configure(bg="#fde2e4")

        frame = ttk.Frame(win, style="Pink.TFrame")
        frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

        tk.Label(frame, text="Количество столбцов", bg="#fadadd").pack(anchor="w")

        count_var = tk.IntVar(value=1)
        count_spin = tk.Spinbox(frame, from_=1, to=20, textvariable=count_var)
        count_spin.pack(fill=tk.X, pady=5)

        columns_frame = ttk.Frame(frame)
        columns_frame.pack(fill=tk.BOTH, expand=True, pady=10)

        column_entries = []

        def build_fields():
            for w in columns_frame.winfo_children():
                w.destroy()
            column_entries.clear()

            for i in range(count_var.get()):
                row = ttk.Frame(columns_frame)
                row.pack(fill=tk.X, pady=2)

                name = tk.Entry(row, width=15)
                name.pack(side=tk.LEFT, padx=3)

                dtype = ttk.Combobox(
                    row,
                    state="readonly",
                    values=[
                        "INT",
                        "VARCHAR(255)",
                        "TEXT",
                        "DATE",
                        "DATETIME",
                        "FLOAT",
                        "BOOLEAN"
                    ],
                    width=15
                )
                dtype.set("VARCHAR(255)")
                dtype.pack(side=tk.LEFT, padx=3)

                nullable = tk.BooleanVar(value=True)
                ttk.Checkbutton(row, text="NULL", variable=nullable).pack(side=tk.LEFT)

                column_entries.append((name, dtype, nullable))

        build_fields()
        count_var.trace_add("write", lambda *a: build_fields())

        def apply():
            cursor = self.connection.cursor()

            # получаем существующие столбцы таблицы
            cursor.execute(f"DESCRIBE `{self.table_name}`")
            existing_columns = {row[0].lower() for row in cursor.fetchall()}

            for name, dtype, nullable in column_entries:
                col_name = name.get().strip()

                # пропускаем пустые
                if not col_name:
                    continue

                # ❌ запрещаем повтор id
                if col_name.lower() == "id":
                    messagebox.showwarning(
                        "Ошибка",
                        "Столбец 'id' уже существует и добавляется автоматически"
                    )
                    continue

                # ❌ запрещаем дубликаты
                if col_name.lower() in existing_columns:
                    messagebox.showwarning(
                        "Ошибка",
                        f"Столбец '{col_name}' уже существует"
                    )
                    continue

                null_sql = "NULL" if nullable.get() else "NOT NULL"

                sql = f"""
                ALTER TABLE `{self.table_name}`
                ADD COLUMN `{col_name}` {dtype.get()} {null_sql}
                """

                if not safe_execute(cursor, sql, title="Добавление столбца"):
                    continue

            self.connection.commit()
            win.destroy()
            self.load_data()

        ttk.Button(
            frame,
            text="Применить",
            style="Pink.TButton",
            command=apply
        ).pack(pady=10)

    def search_data(self):
        query = self.search_var.get().strip()
        if not query:
            self.load_data()
            return

        self.tree.delete(*self.tree.get_children())

        cursor = self.connection.cursor()

        # формируем WHERE col1 LIKE %s OR col2 LIKE %s ...
        conditions = " OR ".join([f"{col} LIKE %s" for col in self.columns])
        values = [f"%{query}%"] * len(self.columns)

        sql = f"SELECT * FROM {self.table_name} WHERE {conditions}"
        cursor.execute(sql, values)

        for row in cursor.fetchall():
            self.tree.insert("", tk.END, values=row)

    def load_data(self):
        # очищаем таблицу
        self.tree.delete(*self.tree.get_children())

        cursor = self.connection.cursor()

        # получаем список столбцов
        cursor.execute(f"DESCRIBE `{self.table_name}`")
        self.columns = [row[0] for row in cursor.fetchall()]
        self.pk = self.columns[0]

        # ---------- заголовки ----------
        self.tree["columns"] = self.columns
        self.sort_column_map = {}
        display_columns = []

        for col in self.columns:
            label = get_column_label(self.table_name, col)
            self.tree.heading(col, text=label)
            self.tree.column(col, width=140)
            self.sort_column_map[label] = col
            display_columns.append(label)

        self.sort_column_combo["values"] = display_columns
        if display_columns:
            self.sort_column_combo.current(0)

        # ---------- выполняем SELECT ----------
        if self.search_query:
            conditions = " OR ".join([f"{col} LIKE %s" for col in self.columns])
            values = [f"%{self.search_query}%"] * len(self.columns)
            sql = f"SELECT * FROM `{self.table_name}` WHERE {conditions}"
            cursor.execute(sql, values)
        else:
            cursor.execute(f"SELECT * FROM `{self.table_name}`")

        # ✅ fetchall — ТОЛЬКО ОДИН РАЗ
        rows = cursor.fetchall()

        # ---------- FK lookup ----------
        lookups = {}

        for col in self.columns:
            fk = get_foreign_key_info(self.connection, self.table_name, col)
            if fk:
                ref_table, ref_id, ref_label = fk
                lookups[col] = {}
                cur = self.connection.cursor()
                cur.execute(f"SELECT {ref_id}, {ref_label} FROM `{ref_table}`")
                for i, v in cur.fetchall():
                    lookups[col][str(i)] = str(v)

        # ---------- вывод строк ----------
        for row in rows:
            display_row = []

            for col, value in zip(self.columns, row):
                if col in lookups and value is not None:
                    display_row.append(lookups[col].get(str(value), value))
                else:
                    display_row.append(value)

            self.tree.insert("", tk.END, values=display_row)

    def add_row(self):
        self.open_editor()

    def edit_row(self):
        sel = self.tree.selection()
        if not sel:
            return
        self.open_editor(self.tree.item(sel[0], "values"))

    def delete_row(self):
        sel = self.tree.selection()
        if not sel:
            return

        values = self.tree.item(sel[0], "values")
        record_id = values[0]

        if not messagebox.askyesno(
                "Подтверждение удаления",
                "Вы действительно хотите удалить выбранную запись?"
        ):
            return

        cursor = self.connection.cursor()
        sql = f"DELETE FROM `{self.table_name}` WHERE `{self.pk}`=%s"

        try:
            cursor.execute(sql, (record_id,))
            self.connection.commit()
            self.load_data()

        except Exception as e:
            # 🔴 FK-ограничение
            if handle_delete_fk_error(e, self.table_name):
                return

            # 🔴 остальные ошибки
            handle_error(e, "Ошибка удаления")

    def sort_data(self):
        display_column = self.sort_column_var.get()
        column = self.sort_column_map.get(display_column)

        if not column:
            messagebox.showwarning("Сортировка", "Выберите столбец")
            return

        cursor = self.connection.cursor()

        # формируем SQL
        if self.search_query:
            conditions = " OR ".join([f"{c} LIKE %s" for c in self.columns])
            values = [f"%{self.search_query}%"] * len(self.columns)

            sql = (
                f"SELECT * FROM {self.table_name} "
                f"WHERE {conditions} "
                f"ORDER BY {column} {self.sort_order}"
            )
            cursor.execute(sql, values)
        else:
            sql = (
                f"SELECT * FROM {self.table_name} "
                f"ORDER BY {column} {self.sort_order}"
            )
            if not safe_execute(cursor, sql, title="JOIN таблиц"):
                return

        # обновляем таблицу
        self.tree.delete(*self.tree.get_children())
        for row in cursor.fetchall():
            self.tree.insert("", tk.END, values=row)

        # переключаем направление сортировки
        self.sort_order = "DESC" if self.sort_order == "ASC" else "ASC"

    def open_editor(self, values=None):
        win = tk.Toplevel(self.window)
        win.configure(bg="#fde2e4")

        frame = ttk.Frame(win, style="Pink.TFrame")
        frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

        entries = {}

        cursor = self.connection.cursor()
        cursor.execute(f"DESCRIBE `{self.table_name}`")
        column_types = {row[0]: row[1].lower() for row in cursor.fetchall()}

        for i, col in enumerate(self.columns):
            if col == self.pk:
                continue  # ⛔ id не показываем и не редактируем

            label = get_column_label(self.table_name, col)
            tk.Label(frame, text=label, bg="#fadadd").grid(row=i, column=0)

            fk = get_foreign_key_info(self.connection, self.table_name, col)

            if fk:
                ref_table, ref_id, ref_label = fk

                cur = self.connection.cursor()
                cur.execute(f"SELECT {ref_id}, {ref_label} FROM {ref_table}")
                data = cur.fetchall()

                id_by_label = {str(v): str(i) for i, v in data}
                label_by_id = {str(i): str(v) for i, v in data}

                var = tk.StringVar()
                combo = ttk.Combobox(
                    frame,
                    textvariable=var,
                    values=list(label_by_id.values()),
                    state="readonly"
                )
                combo.grid(row=i, column=1)

                if values:
                    var.set(label_by_id.get(str(values[i]), ""))

                entries[col] = ("fk", combo, id_by_label)


            else:

                e = tk.Entry(frame)

                e.grid(row=i, column=1)

                col_type = column_types.get(col, "")

                hint = ""

                for key, text in COLUMN_HINTS.items():

                    if key in col_type:
                        hint = text

                        break

                if not values and hint:

                    e.insert(0, hint)

                    e.config(fg="gray")

                    def on_focus_in(event, entry=e, h=hint):

                        if entry.get() == h:
                            entry.delete(0, tk.END)

                            entry.config(fg="black")

                    def on_focus_out(event, entry=e, h=hint):

                        if not entry.get():
                            entry.insert(0, h)

                            entry.config(fg="gray")

                    e.bind("<FocusIn>", on_focus_in)

                    e.bind("<FocusOut>", on_focus_out)

                if values:
                    e.delete(0, tk.END)

                    e.insert(0, values[i])

                    e.config(fg="black")

                entries[col] = ("normal", e)

        def save():
            cursor = self.connection.cursor()

            if values is None:
                # -------- INSERT --------
                cols = []
                data = []

                for col in self.columns:
                    if col == self.pk:
                        continue  # ❗️id не вставляем

                    kind, *field = entries[col]

                    if kind == "fk":
                        combo, id_by_label = field
                        data.append(id_by_label.get(combo.get()))
                    else:
                        entry = field[0]
                        entry_value = entry.get()

                        # убираем подсказку
                        if entry_value in COLUMN_HINTS.values():
                            entry_value = None

                        col_type = column_types.get(col, "")

                        # DATE / DATETIME
                        if not validate_datetime(entry_value or "", col_type):
                            messagebox.showerror(
                                "Ошибка ввода",
                                f"Поле «{get_column_label(self.table_name, col)}»\n"
                                f"Неверный формат даты"
                            )
                            return

                        # ЧИСЛОВОЙ ТИП
                        if not validate_numeric(entry_value, col_type):
                            messagebox.showerror(
                                "Ошибка ввода",
                                f"Поле «{get_column_label(self.table_name, col)}»\n"
                                f"Ожидается числовое значение"
                            )
                            return

                        # >= 0
                        if not validate_non_negative(entry_value, col_type):
                            messagebox.showerror(
                                "Ошибка ввода",
                                f"Поле «{get_column_label(self.table_name, col)}»\n"
                                f"Значение должно быть больше или равно 0"
                            )
                            return

                        data.append(entry_value)


                placeholders = ", ".join(["%s"] * len(data))
                cols_sql = ", ".join(cols)

                sql = f"""
                    INSERT INTO `{self.table_name}` ({cols_sql})
                    VALUES ({placeholders})
                """

                if not safe_execute(cursor, sql, data, "Добавление записи"):
                    return


            else:
                # -------- UPDATE --------
                set_part = ", ".join(f"{c}=%s" for c in self.columns[1:])
                data = []

                for col in self.columns[1:]:
                    kind, *field = entries[col]

                    if kind == "fk":
                        combo, id_by_label = field
                        data.append(id_by_label.get(combo.get()))
                    else:
                        entry = field[0]
                        data.append(entry.get())

                # WHERE id = ?
                data.append(entries[self.pk][1].get())

                sql = f"UPDATE `{self.table_name}` SET {set_part} WHERE {self.pk}=%s"

                if not safe_execute(cursor, sql, data, "Редактирование записи"):
                    return

            self.connection.commit()
            win.destroy()
            self.load_data()

        ttk.Button(frame, text="Сохранить", style="Pink.TButton", command=save)\
            .grid(row=len(self.columns), column=0, columnspan=2, pady=10)

# ================== ЗАПУСК ==================
if __name__ == "__main__":
    root = tk.Tk()
    apply_pink_theme(root)
    LoginWindow(root)
    root.mainloop()

