unit DataGenerator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.DateUtils, System.StrUtils, System.Math;


type
  TGender = (genderAny, genderMale, genderFemale);

  TPerson = record
    FirstName : string;
    LastName  : string;
    FullName  : string;
    Email     : string;
    Sex      : string;
    Birthdate : TDate;
    Age : Word;
    MaritalStatus : string;
  end;

type
  TCountryCapital = record
    Country : string;
    Capital : string;
  end;

type
  TUSCiudad = record
    EStado : string;
    Ciudad  : string;
  end;

type
  TCreditCard = record
    Number   : string;
    CardType : string;
  end;

type
  TypeOfSize = (Letters, Numbers);

type
  TDataLocale = (dlLatino, dlUS);  //Para obtener los datos segun el tipo de idioma

  TDataGenerator = class
  private


  public

  // CATEGORIA DE DATOS

    // [ PERSONAL ]

    class function GetRandomPerson(Locale : TDataLocale; Gender : TGender = genderAny; YearOfBirthStart : Word = 1950; YearOfBirthEnd : Word = 1990) : TPerson;
    class function GenerateRandomPhoneNumber(Locale : TDataLocale) : string;
    class function GenerateRandomPhoneNumberType(Locale : TDataLocale) : string;
    class function GenerateRandomHobbies(Locale : TDataLocale) : string;

    // [ NEGOCIOS ]

    class function GenerateRandomJobTitle(Locale : TDataLocale) : string;
    class function GenerateRandomCompany(Locale : TDataLocale; UsarPrefijo : Boolean = True;
                                         UsarIndustria : Boolean = True; UsarSufijo : Boolean = True) : string;

    class function GenerateRandomDepartment(Locale : TDataLocale) : string;
    class function GenerateRandomSector(Locale : TDataLocale) : string;
    class function GenerateRandomOccupation(Locale : TDataLocale) : string;
    class function GenerateEmailFromName(const FirstName, LastName : string) : string;
    class function GenerateEmailFromCompoundName(const FullName, FullLastName : string) : string;
    class function GenerateUserName(Name : string) : string;


    // [ UBICACION ]

    class function GetCountryAndCapital(Locale : TDataLocale; Index : Integer) : TCountryCapital;
    class function GetRandomAddress(Locale : TDataLocale; Index : Integer) : string;
    class function GetStateAndCityUSA(Index : Integer) : TUSCiudad;

    // [ FECHAS ]

    class function GenerateRandomDate(StartDate, EndDate : TDate) : TDate; overload;
    class function GenerateRandomRangeDate(StartYear, EndYear : Integer) : TDate;
    class function GenerateRandomDate(const InitialYear : Word; YearsSpan : Word) : TDate; overload;
    class function GenerateRandomDateTime(StartDate, EndDate : TDateTime) : TDateTime;

    // [ HORAS ]

    class function GenerateRandomTime(StartTime, EndTime : TTime) : TTime;

    // [ NUMEROS ]

    class function RandomRangeDecimal(Min, Max : Double) : Double;
    class function RandomRangeInteger(const aFrom : Integer; aTo : Integer) : Integer;


    // [ MEDICAMENTOS ]

    class function GenerateRandomDrugName(Locale : TDataLocale) : string;


    // [ PERSONALIZADO ]

    class function GenerateRandomWord(Locale : TDataLocale) : string;
    class function GenerateRandomPhrase(Locale : TDataLocale; const aFrom : Integer = 0; aTo : Integer = 1000) : string;
    class function GenerateRandomString(Locale : TDataLocale; StrLength : Integer) : string;


    // [ PAGOS ]

    class function GenerateRandomPaymentMethod(Locale : TDataLocale) : string;
    class function GenerateCreditCard(Formateado : Boolean) : TCreditCard;
    class function GenerateRandomCurrency(Locale : TDataLocale) : string;

    // [ PRODUCTOS ]

    class function GenerateRandomProductName : string;
    class function GenerateRandomProductCategory(Locale : TDataLocale) : string;
    class function GenerateRandomSizeUnit : string;
    class function GenerateRandomWeightUnit : string;
    class function GenerateRandomVolumeUnit : string;
    class function GenerateRandomColorName(Locale : TDataLocale) : string;
    class function GenerateRandomClothingSize(TypeSize : TypeOfSize) : string;
    class function GenerateRandomISBN : string;
    class function GenerateRandomEAN13 : string;
    class function GenerateRandomTrackingNumber : string;
    class function GenerateRandomShippingMethod : string;
    class function GenerateRandomPackageType(Locale : TDataLocale) : string;
    class function GenerateRandomFruit(Locale : TDataLocale) : string;
    class function GenerateRandomDrink(Locale : TDataLocale) : string;
    class function GenerateRandomDish(Locale : TDataLocale) : string;
    class function GenerateRandomSupermarket(Locale : TDataLocale) : string;
    class function GenerateRandomHardware(Locale : TDataLocale) : string;
    class function GenerateRandomStoreItems(Locale : TDataLocale) : string;
    class function GenerateRandomSportItems(Locale : TDataLocale) : string;
    class function GenerateRandomFurnitureItems(Locale : TDataLocale) : string;
    class function GenerateRandomToy(Locale : TDataLocale) : string;
    class function GenerateRandomBeautySalonServices(Locale : TDataLocale) : string;


    class function GetRandomElement(const List : array of string) : string;
  end;

implementation

const
  // DATOS DE AMERICA LATINA

  Nombres_Masculinos_ES : array[0..25] of string = (
    'Carlos', 'Juan', 'José', 'Luis', 'Miguel', 'Fernando', 'Pedro', 'Jorge',
    'Daniel', 'Antonio', 'Alejandro', 'Ricardo', 'Sergio', 'Manuel', 'Diego',
    'Eduardo', 'Andrés', 'Francisco', 'Rafael', 'Roberto', 'Gabriel', 'Oscar',
    'César', 'Mario', 'Arturo', 'Raúl');

  Nombres_Femeninos_ES : array[0..23] of string = (
    'María', 'Ana', 'Sofía', 'Isabel', 'Camila', 'Valeria', 'Wendy', 'Paula',
    'Gabriela', 'Daniela', 'Carolina', 'Verónica', 'Patricia', 'Lucía',
    'Adriana', 'Mónica', 'Laura', 'Andrea', 'Elena', 'Claudia', 'Betty',
    'Paola', 'Josefina', 'Karina');

  Apellidos_ES : array[0..49] of string = (
    'García', 'Martínez', 'Rodríguez', 'López', 'Hernández', 'González',
    'Pérez', 'Sánchez', 'Ramírez', 'Torres', 'Flores', 'Rivera', 'Gómez',
    'Díaz', 'Álvarez', 'Castillo', 'Ortiz', 'Morales', 'Vargas', 'Ramos',
    'Reyes', 'Cruz', 'Gutiérrez', 'Mendoza', 'Aguilar', 'Burgos', 'Romero',
    'Vázquez', 'Silva', 'Moreno', 'Delgado', 'Molina', 'Medina', 'Jiménez',
    'Herrera', 'Rojas', 'Fuentes', 'Navarro', 'Paredes', 'Salinas', 'Mejía',
    'Escobar', 'Cabrera', 'Ruiz', 'Arroyo', 'Velázquez', 'Montoya', 'Ceballos',
    'Solano', 'Peña');

  // Excepciones para la detección de género
  ExcepcionesMasculinas_ES : array[0..4] of string = (
    'borja', 'josema', 'kosta', 'barnaba', 'matías');

  ExcepcionesFemeninas_ES : array[0..3] of string = (
    'mercedes', 'dolores', 'consuelo', 'remedios');


  PASATIEMPOS_ES : array[0..66] of string = (
    'Impresión 3D', 'Actuación', 'Mochilero', 'Paracaidismo base', 'Béisbol',
    'Baloncesto', 'Juegos de mesa', 'Culturismo', 'Caligrafía', 'Tueste de café',
    'Colorear', 'Programación informática', 'Cocinar', 'Ganchillo', 'Criptografía',
    'Ciclismo', 'Artes digitales', 'Teatro', 'Dibujo', 'Conducir',
    'Electrónica', 'Bordado', 'Moda', 'Pesca', 'Videojuegos',
    'Jardinería', 'Genealogía', 'Soplado de vidrio', 'Graffiti', 'Senderismo',
    'Elaboración casera de cerveza', 'Trote', 'Kayak', 'Kitesurf', 'Tejer',
    'Construcción con Lego', 'Ganzúa', 'Bicicleta de montaña', 'Montañismo', 'Orientación',
    'Pintura', 'Fotografía', 'Polo', 'Alfarería', 'Rompecabezas',
    'Acolchado', 'Rafting', 'Rapel', 'Lectura', 'Escalada en roca',
    'Correr', 'Navegación a vela', 'Scrapbooking', 'Buceo', 'Escultura',
    'Costura', 'Cantar', 'Patín sobre ruedas', 'Dibujo a mano alzada', 'Comedia en vivo',
    'Sudoku', 'Surf', 'Tenis de mesa', 'Videojuegos', 'Deportes acuáticos',
    'Escritura', 'Yoga');


  Titulos_ES : array[0..29] of string = (
    'Ingeniero', 'Médico', 'Abogado', 'Arquitecto', 'Contador', 'Profesor',
    'Enfermero', 'Técnico', 'Psicólogo', 'Administrador', 'Diseñador',
    'Científico', 'Veterinario', 'Agrónomo', 'Economista', 'Geólogo',
    'Periodista', 'Químico', 'Sociólogo', 'Antropólogo', 'Bibliotecario',
    'Matemático', 'Físico', 'Historiador', 'Lingüista', 'Traductor', 'Actor',
    'Chef', 'Piloto', 'Biólogo');

  // Listados de términos para cada parte del nombre de la compañia

  // Prefijos descriptivos en español
  PREFIXES_ES : array[0..29] of string = (
    'Nacional', 'Internacional', 'Ibérica', 'Hispana', 'Latina', 'Latinoamericana',
    'Andina', 'Caribeña', 'Mexicana', 'Colombiana', 'Argentina', 'Chilena',
    'Peruana', 'Venezolana', 'Centroamericana', 'Suramericana', 'Americana',
    'Continental', 'Atlántica', 'Pacífica', 'Universal', 'Global', 'Mundial',
    'Avanzada', 'Nueva', 'Unión', 'Profesional', 'Integral', 'Grupo', 'Alianza');

  // Industrias y tipos de negocio en español
  INDUSTRIES_ES : array[0..57] of string = (
    'Sistemas', 'Tecnología', 'Comunicación', 'Móvil', 'Celular', 'Telefonía',
    'Redes', 'Electrónica', 'Computación', 'Informática', 'Digital',
    'Telecomunicaciones', 'Entretenimiento', 'Financiera', 'Bancaria',
    'Asesores', 'Servicios', 'Consultoría', 'Logística', 'Alta Tecnología',
    'Energía Renovable', 'Gas Natural', 'Hidrocarburos', 'Petróleo',
    'Energía Solar', 'Energía Eólica', 'Biocombustibles', 'Energía',
    'Recursos', 'Electricidad', 'Inversiones', 'Seguros', 'Finanzas',
    'Construcción', 'Desarrollos', 'Proyectos', 'Ingeniería', 'Arquitectura',
    'Software', 'Automotriz', 'Motores', 'Equipamiento', 'Maquinaria',
    'Agroindustria', 'Agricultura', 'Exportación', 'Comercial',
    'Textil', 'Alimentos', 'Bebidas', 'Química', 'Farmacéutica',
    'Minera', 'Industrial', 'Forestal', 'Pesca', 'Metalúrgica', 'Acero');

  // Más industrias para mayor variedad
  INDUSTRIES2_ES : array[0..31] of string = (
    'Negocios', 'Emprendimientos', 'Soluciones', 'Innovación', 'Comercio',
    'Seguridad', 'Instrumentos', 'Laboratorios', 'Óptica', 'Desarrolladora',
    'Viajes', 'Turismo', 'Transportes', 'Investigación', 'Exploración',
    'Gestión', 'Consultores', 'Medios', 'Comunicaciones', 'Marketing',
    'Materiales', 'Productos', 'Distribución', 'Importadora', 'Exportadora',
    'Industria', 'Salud', 'Hospitalaria', 'Educación', 'Capacitación',
    'Tecnológica', 'Biotecnología');

  // Sufijos de la compañía en español
  SUFFIXES_ES : array[0..9] of string = (
    'S.A.', 'S.A.S.', 'S.R.L.', 'S. de R.L.', 'Ltda.',
    'C.A.', 'SpA', 'Grupo', 'Corporación', 'Compañía');

  Departamentos_ES : array[0..29] of string = (
    'Marketing', 'Finanzas', 'Investigación y Desarrollo', 'Producción',
    'Ventas', 'Atención al Cliente', 'Recursos Humanos', 'Logística', 'Compras',
    'Legal', 'Planificación', 'Comunicación', 'Relaciones Públicas',
    'Control de Calidad', 'Innovación', 'Sistemas', 'Mantenimiento',
    'Exportaciones', 'Importaciones', 'Auditoría', 'Desarrollo de Producto',
    'Almacén', 'Transporte', 'Análisis de Datos', 'Ingeniería', 'Operaciones',
    'Seguridad', 'Administración', 'Proyectos', 'Consultoría');

  Sectores_ES : array[0..49] of string = (
    'Alimentos y Bebidas', 'Automotriz', 'Agricultura', 'Aeronáutica',
    'Biotecnología', 'Construcción', 'Consultoría', 'Energía', 'Finanzas',
    'Salud', 'Tecnología', 'Telecomunicaciones', 'Textil', 'Turismo',
    'Transporte', 'Seguros', 'Banca', 'Minería', 'Farmacéutica', 'Educación',
    'Comercio', 'Logística', 'Entretenimiento', 'Medios', 'Petroquímica',
    'Química', 'Petróleo y Gas', 'Bienes Raíces', 'Retail', 'Agua y Saneamiento',
    'Electrónica', 'Defensa', 'Producción Audiovisual', 'Servicios Públicos',
    'Software', 'Hardware', 'E-commerce', 'Publicidad', 'Horticultura',
    'Mecánica', 'Mobiliario', 'Joyería', 'Papelería', 'Seguridad', 'Ingeniería',
    'Gestión Ambiental', 'Artes Gráficas', 'Carpintería', 'Cerámica',
    'Automatización');

  Ocupaciones_ES : array[0..49] of string = (
    'Ingeniero Civil', 'Médico General', 'Abogado', 'Profesor', 'Contador',
    'Psicólogo', 'Arquitecto', 'Enfermero', 'Ingeniero de Sistemas',
    'Diseñador Gráfico', 'Electricista', 'Mecánico', 'Carpintero', 'Cocinero',
    'Policía', 'Bombero', 'Agrónomo', 'Químico', 'Físico', 'Matemático',
    'Periodista', 'Traductor', 'Veterinario', 'Farmacéutico',
    'Técnico de Laboratorio', 'Administrador de Empresas',
    'Técnico en Informática', 'Piloto', 'Marino', 'Barman', 'Chef',
    'Historiador', 'Geógrafo', 'Socólogo', 'Economista', 'Técnico Electricista',
    'Plomero', 'Técnico Automotriz', 'Guía Turístico', 'Fotógrafo', 'Actor',
    'Cantante', 'Músico', 'Bailarín', 'Escritor', 'Editor', 'Publicista',
    'Comunicador Social', 'Antropólogo', 'Diseñador de Moda');


  // PALABRAS EN ESPAÑOL

  WORDS_ES : array [0 .. 1000] of string = ('morder', 'compañero', 'pluma', 'espalda', 'iglesia', 'pera', 'tejer', 'doblado', 'llave', 'grieta', 'celestial',
    'engañar', 'enloquecedor', 'simple', 'escritor', 'rápido', 'ácido', 'decidir', 'sombrero', 'pintar', 'vaca', 'disfuncional', 'mascota', 'jirafa',
    'conexión', 'agrio', 'voraz', 'nublado', 'irónico', 'curva', 'acordar', 'ponche', 'escamoso', 'minucioso', 'cálido', 'seda', 'helado',
    'infernal', 'juguete', 'lechoso', 'falda', 'prueba', 'alocado', 'cuestionable', 'juguetón', 'consciente', 'baya', 'trono', 'horno', 'restar', 'fresco',
    'cuidar', 'cargo', 'romper', 'curva', 'cómodo', 'estrecho', 'misericordioso', 'material', 'miedo', 'ejercicio', 'delgado', 'fuego',
    'tormenta', 'cola', 'poco descriptivo', 'calculador', 'paquete', 'acero', 'maravilloso', 'béisbol', 'furtivo', 'puntada', 'permanente', 'vacío',
    'arbustos', 'doloroso', 'tenso', 'verso', 'no escrito', 'reproducir', 'receptivo', 'botella', 'sedoso', 'supuesto', 'tacaño', 'irritar',
    'expandir', 'gorra', 'inadecuado', 'gigantesco', 'existir', 'húmedo', 'fregar', 'asqueado', 'sol', 'tinta', 'detallado', 'derrotado', 'económico',
    'robusto', 'parar', 'desbordar', 'numeroso', 'alegre', 'limpiar', 'beber', 'error', 'rama', 'masculino', 'orgulloso', 'empapado', 'barco', 'excitar',
    'industria', 'melancólico', 'hombre', 'vacaciones', 'doctor', 'travieso', 'avión', 'ignorar', 'abrir', 'actuar', 'terremoto', 'inconcluso',
    'reflejar', 'fuerza', 'gracioso', 'maravilla', 'magenta', 'cerca', 'presa', 'ventoso', 'sirvienta', 'chiflado', 'liberar', 'cumpleaños', 'declaración',
    'psicótico', 'arenas movedizas', 'cosas', 'aviones', 'límite', 'asentir', 'tocar', 'discutir', 'pecado', 'tren', 'improvisado', 'aguja', 'arrepentir',
    'golpe', 'fortalecer', 'moretón', 'mío', 'vara', 'impuesto', 'ramita', 'aconsejar', 'sello', 'rima', 'desagradable', 'poco', 'informar', 'fijo',
    'buzón', 'campanas', 'grado', 'máquina', 'hilo', 'aclarar', 'bañera', 'inocente', 'caliente', 'brumoso', 'furgoneta', 'aletear', 'entrometido', 'amistoso',
    'crimen', 'ingenioso', 'desinteresado', 'ruidoso', 'torpe', 'chillar', 'página', 'mojado', 'avergonzado', 'largo plazo', 'cerrado', 'idioma',
    'argumento', 'élite', 'prohibir', 'viaje', 'tour', 'vino', 'ganancia', 'envidioso', 'amor', 'espalda', 'pequeño', 'mágico', 'arrebatar', 'eufórico',
    'olfatear', 'lejos', 'tímido', 'profundamente', 'zoom', 'inventar', 'centro', 'desgarrador', 'enfadado', 'lata', 'cubo', 'importante', 'buscar',
    'zapato', 'yo', 'rayos X', 'aborrecible', 'grumoso', 'fértil', 'nido', 'elegir', 'historia', 'extraño', 'interrumpir', 'gritar', 'grano',
    'centelleante', 'seductor', 'reyezuelo', 'forma', 'ataque', 'anterior', 'sospechoso', 'hija', 'mohoso', 'señal', 'plácido', 'peculiar',
    'picazón', 'mantequilla', 'ordinario', 'imaginario', 'lista', 'conocido', 'sirviente', 'lento', 'vestimenta', 'reunión', 'encantador', 'murciélago', 'seguro',
    'desperdiciar', 'aromático', 'pie', 'frágil', 'teoría', 'rígido', 'crema', 'tren', 'suelo', 'combustible', 'cauteloso', 'tienda', 'maravilloso', 'maíz',
    'vivaz', 'elegante', 'riesgo', 'prosa', 'intentar', 'verde', 'cuenta', 'recreo', 'cortar', 'mancha', 'descolorido', 'calor', 'cámara', 'pánico',
    'deprimido', 'madera', 'torpe', 'crédulo', 'ferrocarril', 'guía', 'actual', 'gigantes', 'entrar', 'talentoso', 'bullicioso', 'cuadrado',
    'joya', 'abeja', 'jalea', 'utópico', 'sanar', 'ira', 'equilibrio', 'tic', 'girar', 'único', 'animado', 'muñeca', 'desvanecer', 'tierno',
    'extrovertido', 'propio', 'suspirar', 'desempleado', 'hirviendo', 'paralelo', 'chaleco', 'cuero', 'chispa', 'chupar', 'nudo', 'círculo', 'cuadrado', 'suministro',
    'tanque', 'fax', 'inmaculado', 'habitual', 'sentimiento', 'reloj', 'ganado', 'fin', 'verdadero', 'atontado', 'veneno', 'hombre', 'pedal', 'grosero',
    'gemido', 'descerebrado', 'hueso', 'mancha', 'regordete', 'innumerable', 'ojo', 'brillante', 'dulce', 'fanático', 'naranjas', 'calma', 'aplastar',
    'diente', 'pequeño', 'diseño', 'uno', 'golpe', 'aberrante', 'mío', 'encajar', 'frotar', 'óptimo', 'feo', 'lírico', 'pedir prestado', 'cola',
    'alerta', 'normal', 'iracundo', 'agresivo', 'nivel', 'hueco', 'desilusionado', 'patear', 'clima', 'poderoso', 'optimista', 'preocupado',
    'presumido', 'muchos', 'advertir', 'agradecer', 'trenes', 'plan', 'ahogar', 'actividad', 'atender', 'caminar', 'pensamiento', 'parlanchín', 'actor', 'espinoso',
    'oler', 'peligroso', 'observación', 'acción', 'estable', 'hipnótico', 'segunda mano', 'cremallera', 'mundano', 'arena', 'sigiloso', 'daño',
    'panqueque', 'garantía', 'vacío', 'bombilla', 'quemar', 'rechazar', 'decorar', 'obeso', 'multitud', 'aplaudir', 'plano', 'disponible', 'saltar', 'desordenado',
    'naufragio', 'abrochar', 'olas', 'dinosaurios', 'lúgubre', 'temeroso', 'respuesta', 'reseco', 'apretado', 'animado', 'escritorio', 'hastiado', 'cera',
    'plata', 'gritar', 'desconcertante', 'imparcial', 'unir', 'rama', 'cuac', 'escritura', 'bromear', 'menta', 'lleno', 'plato', 'ventoso', 'oso',
    'campana', 'brillante', 'absurdo', 'pasado', 'ensordecedor', 'decoroso', 'desaconsejable', 'papel', 'batalla', 'amigo', 'control', 'rico',
    'arrepentimiento', 'usado', 'disperso', 'redundante', 'esclavo', 'lánguido', 'didáctico', 'hadas', 'sofá', 'rencoroso', 'responder', 'división',
    'motor', 'suponer', 'sin hogar', 'pellizcar', 'rayo', 'canal', 'repetir', 'humo', 'concentrar', 'práctico', 'comité', 'canciones', 'locamente',
    'picar', 'manos', 'limpio', 'suma', 'majestuoso', 'cuidadoso', 'falaz', 'vigilado', 'último', 'tiempo', 'caer', 'plástico', 'fuerza',
    'adivinar', 'uva', 'amoroso', 'mano', 'permanecer', 'vigoroso', 'lavar', 'coches', 'mismo', 'proveer', 'estante', 'ñame', 'oneroso', 'reclamar',
    'vagabundo', 'reluciente', 'inocente', 'cerrar', 'cerca', 'absorbente', 'diario', 'enloquecido', 'gestionar', 'enérgico', 'ausente', 'fantástico',
    'irreverente', 'antinatural', 'cantidad', 'exuberante', 'trébol', 'alerta', 'rueda', 'sótano', 'agonizante', 'tarjeta', 'memorizar', 'comida',
    'suspender', 'preocupado', 'desigual', 'trastornado', 'espiritual', 'arco', 'atreverse', 'martillo', 'tirar', 'saltar', 'florero', 'planta', 'color', 'gusano',
    'agarrar', 'marco', 'sabor', 'incandescente', 'pequeño', 'regla', 'confundido', 'espacioso', 'hermoso', 'calor', 'entero', 'galleta', 'agua',
    'endeble', 'agudo', 'abuelo', 'espeluznante', 'natural', 'grasa', 'silencioso', 'superficial', 'mirar', 'dedo', 'permitirse',
    'racial', 'cansado', 'tremendo', 'celoso', 'resbalar', 'posición', 'montañoso', 'refugio', 'calculadora', 'cursi', 'látigo',
    'montaña', 'claro', 'delgado', 'oler', 'hormigas', 'amarillo', 'cruzar', 'emplear', 'problema', 'deslumbrante', 'encantador', 'estupendo', 'medir',
    'desaprobar', 'elástico', 'brillar', 'cachorro', 'tonto', 'discusión', 'tormentoso', 'pasteles', 'absorto', 'basura', 'mamut', 'bajo',
    'moderado', 'insignia', 'carta', 'previo', 'desafío', 'agrio', 'lindo', 'traje', 'condición', 'costoso', 'regla', 'incorrecto', 'bomba', 'delgado',
    'nadar', 'grieta', 'repugnante', 'reunir', 'mitad', 'robusto', 'probable', 'arroyo', 'truco', 'tonto', 'malhumorado', 'uña', 'podrido', 'revolver',
    'estornudar', 'incluso', 'inflexible', 'desordenado', 'objeto', 'batalla', 'pequeño', 'esperar', 'instintivo', 'burro', 'aprensivo', 'lluvioso',
    'cobarde', 'aceptable', 'ronco', 'contaminación', 'juicioso', 'distribución', 'cuello', 'izquierda', 'recoger', 'agradecido', 'describir',
    'complejo', 'transportar', 'caballos', 'esperanza', 'químico', 'vestido', 'idea', 'extender', 'reír', 'evento', 'ruta', 'manguera', 'abundante',
    'insecto', 'espectacular', 'silbar', 'hogar', 'vasto', 'masivo', 'gris', 'navegar', 'espléndido', 'palabra', 'entrenador', 'reparar', 'chirriar',
    'curioso', 'rayo', 'medio', 'obsceno', 'eficaz', 'supremo', 'letárgico', 'alegre', 'lino', 'causa', 'sinónimo', 'libro', 'valiente',
    'apostando', 'débil', 'mostrar', 'pájaros', 'bárbaro', 'hilarante', 'herir', 'caminar', 'estridente', 'frecuente', 'ancho', 'besar', 'solitario',
    'pendenciero', 'brazo', 'flores', 'rodear', 'nivel', 'disfrutar', 'calcular', 'alcanzar', 'hermano', 'grandioso', 'pegajoso', 'trueno',
    'pluma', 'rastrillo', 'girar', 'afilado', 'cerca', 'tijeras', 'pulir', 'recóndito', 'breve', 'cerdo', 'diez', 'deletrear', 'carbón', 'acera',
    'recto', 'derretido', 'anillo', 'inexpresivo', 'nueve', 'herida', 'usar', 'interruptor', 'reloj', 'carne', 'gobernador', 'animado', 'ordenado', 'elegante',
    'puerta', 'rosa', 'adinerado', 'psicodélico', 'bofetada', 'nota', 'solicitud', 'partido', 'avergonzado', 'caracol', 'bandeja', 'bomba', 'desaparecer',
    'vegetal', 'lana', 'distraído', 'impulso', 'tenedor', 'freno', 'brillante', 'equipo', 'coherente', 'polvo', 'aliviado', 'largo', 'amplio',
    'tienda', 'innato', 'leche', 'madre', 'tornillo', 'cojín', 'escuchar', 'mancha', 'dispuesto', 'piernas', 'inteligente', 'obsoleto', 'bobina', 'humo',
    'llamar', 'hombres', 'propósito', 'irregular', 'recibo', 'calmar', 'pensable', 'lanzar', 'gatitos', 'oceánico', 'muñecas', 'dentado', 'fino',
    'empezar', 'confuso', 'querer', 'desarrollar', 'hábil', 'real', 'hermanas', 'cooperativo', 'retirar', 'espantapájaros', 'cariñoso', 'oportunidad',
    'buscar', 'visitante', 'tallo', 'rabioso', 'semilla', 'soportable', 'enclaustrado', 'cuchillo', 'lanzar', 'problema', 'frío', 'inteligente', 'admitir',
    'base', 'multiplicar', 'escapar', 'bicicleta', 'asustar', 'grande', 'tirar', 'observador', 'estereotipado', 'sucio', 'lata', 'vago', 'apio',
    'hambriento', 'mejor', 'difícil', 'robusto', 'caballo', 'impecable', 'fresco', 'curioso', 'ilegal', 'omnisciente', 'simplista', 'egoísta',
    'limpio', 'hospital', 'alentador', 'incompetente', 'correcto', 'aprender', 'relación', 'estropear', 'divertido', 'despiadado', 'sórdido',
    'secuelas', 'aumentar', 'grasiento', 'futurista', 'cerrar', 'amistoso', 'empinado', 'rango', 'débil', 'cárcel', 'asombrado', 'tenso',
    'errático', 'ojos', 'curar', 'abrumado', 'confundir', 'dormitorio', 'escala', 'frotar', 'consciente', 'serpiente', 'caja', 'orden', 'resbaladizo',
    'guapo', 'espía', 'lengua', 'impropio', 'magnífico', 'oro', 'resuelto', 'cara', 'infantil', 'aprobación', 'sustancioso', 'rana',
    'abrasivo', 'rata', 'pelar', 'oficina', 'panorámico', 'explotar', 'selectivo', 'adelante', 'descongelar', 'mezquino', 'extraño', 'odiar', 'ventana', 'sombrío',
    'guardia', 'acertijo', 'juez', 'rebaño', 'negro', 'diversión', 'bicicletas', 'leche', 'calcetín', 'histórico', 'vulgar', 'desnudo', 'mitón', 'severo',
    'calle', 'desigual', 'cinco', 'zinc', 'defectuoso', 'desordenado', 'pensativo', 'picante', 'oval', 'teléfono', 'decisivo', 'diminuto', 'arreglar',
    'sobresaliente', 'excusa', 'abyecto', 'imprimir', 'recibir', 'saltar', 'golpear', 'ubicuo', 'ansioso', 'llenar', 'encogerse', 'osificado',
    'arrepentido', 'seco', 'atrás', 'tío', 'sin voz', 'rociar', 'ciudad', 'aspirante', 'irritable', 'cama', 'agradable', 'ventoso', 'nervioso', 'hablar',
    'poderoso', 'varios', 'arrastrarse', 'carente', 'letal', 'bebé', 'dolorido', 'lamentar', 'comportarse', 'pasar', 'marcar', 'verano', 'causa',
    'destrucción', 'rancio', 'lavabo', 'avergonzar', 'robar', 'ingreso', 'jubiloso', 'sorprendido', 'chispa', 'aire', 'inútil', 'hospitalario',
    'dinámico', 'empujar', 'nervioso', 'oscuro', 'barbilla', 'shock', 'marco', 'dojo');


  CommonCurrencies_ES : array[0..32] of string = (
    // América
    'Dólar Estadounidense',       // Estados Unidos
    'Dólar Canadiense',           // Canadá
    'Peso Mexicano',              // México
    'Real Brasileño',             // Brasil
    'Peso Argentino',             // Argentina
    'Peso Chileno',               // Chile
    'Peso Colombiano',            // Colombia
    'Sol Peruano',                // Perú
    'Bolívar Venezolano',         // Venezuela
    'Peso Uruguayo',              // Uruguay
    'Guaraní Paraguayo',          // Paraguay
    'Boliviano',                  // Bolivia
    'Dólar Estadounidense',       // Ecuador (usa el dólar estadounidense)
    'Colón Costarricense',        // Costa Rica
    'Balboa Panameño',            // Panamá (usa el dólar estadounidense)
    'Lempira Hondureña',          // Honduras
    'Quetzal Guatemalteco',       // Guatemala
    'Córdoba Nicaragüense',       // Nicaragua
    'Colón Salvadoreño',          // El Salvador (usa el dólar estadounidense)
    'Peso Dominicano',            // República Dominicana
    'Gourde Haitiano',            // Haití
    'Dólar Jamaiquino',           // Jamaica
    'Dólar Bahameño',             // Bahamas
    'Dólar Barbadense',           // Barbados
    'Dólar de Trinidad y Tobago', // Trinidad y Tobago
    'Dólar Guyanés',              // Guyana
    'Peso Cubano',                // Cuba
    'Florín Arubeño',             // Aruba
    // Europa
    'Euro',                       // Zona Euro (19 países)
    'Libra Esterlina',            // Reino Unido
    'Franco Suizo',               // Suiza
    'Rublo Ruso',                 // Rusia
    'Grivna Ucraniana'           // Ucrania
  );


  // DATOS DE LOS ESTADOS UNIDOS

  // Nombres en inglés (masculinos y femeninos por separado)
  Nombres_Masculinos_US : array[0..29] of string = (
    'Michael', 'James', 'John', 'Robert', 'David', 'William', 'Richard',
    'Thomas', 'Charles', 'Christopher', 'Daniel', 'Matthew', 'Anthony', 'Mark',
    'Andrew', 'Joshua', 'Joseph', 'Brian', 'Kevin', 'Jason', 'Justin', 'Ryan',
    'Jacob', 'Nicholas', 'Brandon', 'Samuel', 'Nathan', 'Aaron', 'Adam', 'Benjamin');

  Nombres_Femeninos_US : array[0..19] of string = (
    'Emily', 'Jessica', 'Ashley', 'Sarah', 'Amanda', 'Brittany', 'Elizabeth',
    'Megan', 'Hannah', 'Lauren', 'Kayla', 'Taylor', 'Rachel', 'Victoria',
    'Emma', 'Olivia', 'Sophia', 'Isabella', 'Abigail', 'Chloe');

  Apellidos_US : array[0..49] of string = (
    'Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller',
    'Davis', 'Rodriguez', 'Martinez', 'Hernandez', 'Lopez', 'Gonzalez',
    'Wilson', 'Anderson', 'Thomas', 'Taylor', 'Moore', 'Jackson', 'Martin',
    'Lee', 'Perez', 'Thompson', 'White', 'Harris', 'Sanchez', 'Clark', 'Ramirez',
    'Lewis', 'Robinson', 'Walker', 'Young', 'Allen', 'King', 'Wright', 'Scott',
    'Torres', 'Nguyen', 'Hill', 'Flores', 'Green', 'Adams', 'Nelson', 'Baker',
    'Hall', 'Rivera', 'Campbell', 'Mitchell', 'Carter', 'Roberts');

  // Excepciones para la detección de género
  ExcepcionesMasculinas_US : array[0..2] of string = ('joshua', 'elisha', 'ezra');

  ExcepcionesFemeninas_US : array[0..3] of string = ('alex', 'sam', 'chris', 'pat');


  PASATIEMPOS_US : array[0..66] of string = (
    '3D printing', 'Acting', 'Backpacking', 'Base jumping', 'Baseball',
    'Basketball', 'Board games', 'Bodybuilding', 'Calligraphy', 'Coffee roasting',
    'Colouring', 'Computer programming', 'Cooking', 'Crocheting', 'Cryptography',
    'Cycling', 'Digital arts', 'Drama', 'Drawing', 'Driving',
    'Electronics', 'Embroidery', 'Fashion', 'Fishing', 'Gaming',
    'Gardening', 'Genealogy', 'Glassblowing', 'Graffiti', 'Hiking',
    'Homebrewing', 'Jogging', 'Kayaking', 'Kitesurfing', 'Knitting',
    'Lego building', 'Lockpicking', 'Mountain biking', 'Mountaineering', 'Orienteering',
    'Painting', 'Photography', 'Polo', 'Pottery', 'Puzzles',
    'Quilting', 'Rafting', 'Rappelling', 'Reading', 'Rock climbing',
    'Running', 'Sailing', 'Scrapbooking', 'Scuba diving', 'Sculpting',
    'Sewing', 'Singing', 'Skateboarding', 'Sketching', 'Stand-up comedy',
    'Sudoku', 'Surfing', 'Table tennis', 'Video gaming', 'Water sports',
    'Writing', 'Yoga');

  Titulos_US : array[0..29] of string = (
    'Engineer', 'Doctor', 'Lawyer', 'Architect', 'Accountant', 'Teacher',
    'Nurse', 'Technician', 'Psychologist', 'Manager', 'Designer', 'Scientist',
    'Veterinarian', 'Agronomist', 'Economist', 'Geologist', 'Journalist',
    'Chemist', 'Sociologist', 'Anthropologist', 'Librarian', 'Mathematician',
    'Physicist', 'Historian', 'Linguist', 'Translator', 'Actor', 'Chef',
    'Pilot', 'Biologist');


  // Listados de términos para cada parte del nombre de la compañia

  // Prefijos descriptivos en ingles
  PREFIXES_US : array[0..29] of string = (
    'American', 'Australian', 'Canadian', 'Pacific', 'Federal', 'Global',
    'Domestic', 'First', 'General', 'Western', 'West', 'West Coast',
    'North', 'East', 'South', 'Flexible', 'City', 'WorldWide', 'Home',
    'Advanced', 'Beyond', 'Future', 'National', 'International',
    'Union', 'United', 'Special', 'Professional', 'Smart', 'Creative');

  // Industrias y tipos de negocio en ingles
  INDUSTRIES_US : array[0..56] of string = (
    'Systems', '2G Wireless', '3G Wireless', '4G Wireless', '5G Wireless',
    'Mobile', 'A-Mobile', 'B-Mobile', 'C-Mobile', 'D-Mobile', 'E-Mobile',
    'F-Mobile', 'G-Mobile', 'Telecom', 'Telecommunications', '2D Electronic',
    '3D Electronic', '4D Electronic', '5D Electronic', '6D Electronic',
    '7D Electronic', 'Entertainment', 'Financial', 'Financial Experts',
    'Services', 'Devices', 'Logics', 'Logistic', 'High-Technologies',
    'Technologies', 'Renewable Energy', 'Natural Gas', 'Fossil Fuel', 'Wave',
    'Thermal', 'Solar', 'Wind', 'Green', 'Nuclear', 'Energy', 'Resources',
    'Power', 'Oil', 'Electricity', 'Gas', 'Investment', 'Insurance',
    'Broadcasting', 'Trust', 'Tire & Rubber', 'Engineering', 'Protection',
    'Software', 'Cars', 'Cars Battery', 'Equipment', 'Semiconductor');

  // Más industrias para mayor variedad en ingles
  INDUSTRIES2_US : array[0..31] of string = (
    'Business', 'Mining', 'Heating', 'Partners', 'Data', 'Computers', 'Security',
    'Petroleum', 'Instruments', 'Laboratories', 'Lasers & Optics', 'Optics',
    'Travel', 'Space Research', 'Research', 'Explore', 'Management',
    'Consulting', 'Media', 'Telemetrics', 'Development', 'Materials',
    'Goods', 'Foods', 'Transport', 'Transportation', 'Industry',
    'Health', 'Health Care', 'Automotive', 'Products', 'Delivery');

  // Sufijos de la compañía en ingles
  SUFFIXES_US : array[0..4] of string = ('Inc.', 'Co.', 'Corp.', 'Group',
                                         'Corporation');


  Departamentos_US : array[0..29] of string = (
    'Marketing', 'Finance', 'Research and Development', 'Manufacturing', 'Sales',
    'Customer Support', 'Human Resources', 'Logistics', 'Procurement', 'Legal',
    'Planning', 'Communications', 'Public Relations', 'Quality Control',
    'Innovation', 'IT', 'Maintenance', 'Exports', 'Imports', 'Audit',
    'Product Development', 'Warehouse', 'Transportation', 'Data Analysis',
    'Engineering', 'Operations', 'Security', 'Administration',
    'Project Management', 'Consulting');

  Sectores_US : array[0..49] of string = (
    'Food and Beverage', 'Automotive', 'Agriculture', 'Aerospace',
    'Biotechnology', 'Construction', 'Consulting', 'Energy', 'Finance',
    'Healthcare', 'Technology', 'Telecommunications', 'Textile', 'Tourism',
    'Transportation', 'Insurance', 'Banking', 'Mining', 'Pharmaceuticals',
    'Education', 'Commerce', 'Logistics', 'Entertainment', 'Media',
    'Petrochemical', 'Chemical', 'Oil and Gas', 'Real Estate', 'Retail',
    'Water and Sanitation', 'Electronics', 'Defense', 'Film Production',
    'Public Utilities', 'Software', 'Hardware', 'E-commerce', 'Advertising',
    'Horticulture', 'Mechanics', 'Furniture', 'Jewelry', 'Stationery',
    'Security', 'Engineering', 'Environmental Management', 'Graphic Arts',
    'Carpentry', 'Ceramics', 'Automation');

  Ocupaciones_US : array[0..49] of string = (
    'Software Engineer', 'Physician', 'Lawyer', 'Teacher', 'Accountant',
    'Psychologist', 'Architect', 'Nurse', 'IT Specialist', 'Graphic Designer',
    'Electrician', 'Mechanic', 'Carpenter', 'Chef', 'Police Officer',
    'Firefighter', 'Agronomist', 'Chemist', 'Physicist', 'Mathematician',
    'Journalist', 'Translator', 'Veterinarian', 'Pharmacist', 'Lab Technician',
    'Business Administrator', 'Computer Technician', 'Pilot', 'Marine',
    'Bartender', 'Chef', 'Historian', 'Geographer', 'Sociologist', 'Economist',
    'Electrical Technician', 'Plumber', 'Automotive Technician', 'Tour Guide',
    'Photographer', 'Actor', 'Singer', 'Musician', 'Dancer', 'Writer',
    'Editor', 'Advertiser', 'Social Media Manager', 'Anthropologist',
    'Fashion Designer');


  // PALABRAS EN INGLES

  WORDS_US : array [0 .. 1000] of string = ('bite', 'mate', 'quill', 'back', 'church', 'pear', 'knit', 'bent', 'wrench', 'crack', 'heavenly',
    'deceive', 'maddening', 'plain', 'writer', 'rapid', 'acidic', 'decide', 'hat', 'paint', 'cow', 'dysfunctional', 'pet', 'giraffe',
    'connection', 'sour', 'voracious', 'cloudy', 'wry', 'curve', 'agree', 'eggnog', 'flaky', 'painstaking', 'warm', 'silk', 'icy',
    'hellish', 'toy', 'milky', 'skirt', 'test', 'daffy', 'questionable', 'gamy', 'aware', 'berry', 'throne', 'oven', 'subtract', 'cool',
    'care', 'charge', 'smash', 'curve', 'comfortable', 'narrow', 'merciful', 'material', 'fear', 'exercise', 'skinny', 'fire',
    'rainstorm', 'tail', 'nondescript', 'calculating', 'pack', 'steel', 'marvelous', 'baseball', 'furtive', 'stitch', 'abiding', 'empty',
    'bushes', 'painful', 'tense', 'verse', 'unwritten', 'reproduce', 'receptive', 'bottle', 'silky', 'alleged', 'stingy', 'irritate',
    'expand', 'cap', 'unsuitable', 'gigantic', 'exist', 'damp', 'scrub', 'disgusted', 'sun', 'ink', 'detailed', 'defeated', 'economic',
    'chunky', 'stop', 'overflow', 'numerous', 'joyous', 'wipe', 'drink', 'error', 'branch', 'male', 'proud', 'soggy', 'ship', 'excite',
    'industry', 'wistful', 'man', 'vacation', 'doctor', 'naughty', 'plane', 'ignore', 'open', 'act', 'earthquake', 'inconclusive',
    'reflect', 'force', 'funny', 'wonder', 'magenta', 'near', 'dam', 'windy', 'maid', 'wacky', 'release', 'birthday', 'statement',
    'psychotic', 'quicksand', 'things', 'planes', 'boundary', 'nod', 'touch', 'argue', 'sin', 'train', 'adhoc', 'needle', 'regret',
    'stroke', 'strengthen', 'bruise', 'mine', 'rod', 'tax', 'twig', 'advise', 'stamp', 'rhyme', 'obnoxious', 'few', 'inform', 'fixed',
    'mailbox', 'bells', 'grade', 'machine', 'yarn', 'lighten', 'tub', 'guiltless', 'hot', 'misty', 'van', 'flap', 'nosy', 'neighborly',
    'crime', 'nifty', 'uninterested', 'noisy', 'oafish', 'squeal', 'page', 'wet', 'embarrassed', 'long-term', 'closed', 'language',
    'argument', 'elite', 'ban', 'trip', 'tour', 'wine', 'profit', 'envious', 'love', 'back', 'bite-sized', 'magical', 'snatch', 'elated',
    'sniff', 'far', 'shy', 'deeply', 'zoom', 'invent', 'downtown', 'heartbreaking', 'angry', 'can', 'bucket', 'important', 'fetch',
    'shoe', 'self', 'x-ray', 'abhorrent', 'lumpy', 'fertile', 'nest', 'pick', 'history', 'offbeat', 'interrupt', 'yell', 'grain',
    'scintillating', 'alluring', 'wren', 'form', 'attack', 'foregoing', 'suspect', 'daughter', 'moldy', 'signal', 'placid', 'quirky',
    'itchy', 'butter', 'ordinary', 'imaginary', 'list', 'known', 'servant', 'slow', 'apparel', 'meeting', 'lovely', 'bat', 'insurance',
    'waste', 'aromatic', 'foot', 'breakable', 'theory', 'stiff', 'cream', 'train', 'ground', 'fuel', 'wary', 'store', 'wonderful', 'corn',
    'zippy', 'dashing', 'risk', 'prose', 'try', 'green', 'bead', 'recess', 'chop', 'stain', 'faded', 'heat', 'camera', 'panicky',
    'depressed', 'wooden', 'clumsy', 'gullible', 'railway', 'guide', 'current', 'giants', 'enter', 'talented', 'bustling', 'square',
    'jewel', 'bee', 'jelly', 'utopian', 'heal', 'anger', 'balance', 'tick', 'turn', 'unique', 'lively', 'wrist', 'fade', 'tender',
    'outgoing', 'own', 'sigh', 'jobless', 'boiling', 'parallel', 'vest', 'leather', 'spark', 'suck', 'knot', 'circle', 'square', 'supply',
    'tank', 'fax', 'spotless', 'habitual', 'feeling', 'watch', 'cattle', 'end', 'true', 'zonked', 'poison', 'man', 'pedal', 'boorish',
    'moaning', 'mindless', 'bone', 'spot', 'chubby', 'numberless', 'eye', 'bright', 'sweet', 'fanatical', 'oranges', 'calm', 'squash',
    'tooth', 'petite', 'design', 'one', 'bump', 'aberrant', 'mine', 'fit', 'rub', 'optimal', 'ugly', 'lyrical', 'borrow', 'queue',
    'alert', 'normal', 'wrathful', 'truculent', 'level', 'hollow', 'disillusioned', 'kick', 'weather', 'mighty', 'upbeat', 'troubled',
    'snotty', 'many', 'warn', 'thank', 'trains', 'plan', 'choke', 'activity', 'attend', 'walk', 'thought', 'gabby', 'actor', 'prickly',
    'smell', 'dangerous', 'observation', 'action', 'steady', 'hypnotic', 'second-hand', 'zip', 'mundane', 'sand', 'sneaky', 'harm',
    'pancake', 'guarantee', 'empty', 'bulb', 'burn', 'reject', 'decorate', 'obese', 'crowd', 'clap', 'flat', 'available', 'hop', 'untidy',
    'wreck', 'fasten', 'waves', 'dinosaurs', 'dreary', 'fearful', 'answer', 'parched', 'tight', 'animated', 'desk', 'jaded', 'wax',
    'silver', 'scream', 'puzzling', 'unbiased', 'unite', 'branch', 'quack', 'writing', 'tease', 'mint', 'full', 'plate', 'gusty', 'bear',
    'bell', 'sparkling', 'absurd', 'past', 'earsplitting', 'seemly', 'unadvised', 'paper', 'battle', 'friend', 'control', 'rich',
    'regret', 'used', 'scattered', 'redundant', 'slave', 'languid', 'didactic', 'fairies', 'sofa', 'spiteful', 'reply', 'division',
    'engine', 'suppose', 'homeless', 'pinch', 'ray', 'channel', 'repeat', 'smoke', 'concentrate', 'handy', 'committee', 'songs', 'madly',
    'itch', 'hands', 'clean', 'addition', 'majestic', 'careful', 'fallacious', 'guarded', 'last', 'time', 'tumble', 'plastic', 'force',
    'guess', 'grape', 'loving', 'hand', 'remain', 'vigorous', 'wash', 'cars', 'same', 'provide', 'shelf', 'yam', 'onerous', 'claim',
    'tramp', 'glistening', 'innocent', 'lock', 'close', 'absorbing', 'daily', 'amuck', 'manage', 'energetic', 'absent', 'fantastic',
    'flippant', 'unnatural', 'amount', 'luxuriant', 'clover', 'alert', 'wheel', 'cellar', 'agonizing', 'card', 'memorise', 'meal',
    'suspend', 'concerned', 'uneven', 'deranged', 'spiritual', 'arch', 'dare', 'hammer', 'tug', 'jump', 'vase', 'plant', 'color', 'worm',
    'grab', 'frame', 'taste', 'incandescent', 'little', 'rule', 'confused', 'roomy', 'gorgeous', 'heat', 'whole', 'cracker', 'water',
    'flimsy', 'high-pitched', 'grandfather', 'spooky', 'natural', 'grease', 'noiseless', 'superficial', 'gaze', 'finger', 'afford',
    'racial', 'tiresome', 'tremendous', 'zealous', 'slip', 'position', 'mountainous', 'shelter', 'calculator', 'tacky', 'whip',
    'mountain', 'clear', 'thin', 'smell', 'ants', 'yellow', 'cross', 'employ', 'trouble', 'dazzling', 'enchanting', 'groovy', 'measure',
    'disapprove', 'elastic', 'sparkle', 'cub', 'foolish', 'discussion', 'stormy', 'pies', 'absorbed', 'trashy', 'mammoth', 'low',
    'subdued', 'badge', 'letter', 'previous', 'challenge', 'tart', 'cute', 'suit', 'condition', 'pricey', 'rule', 'wrong', 'bomb', 'wiry',
    'swim', 'crack', 'disgusting', 'gather', 'half', 'sturdy', 'probable', 'stream', 'trick', 'silly', 'sulky', 'nail', 'rotten', 'stir',
    'sneeze', 'even', 'adamant', 'cluttered', 'object', 'battle', 'petite', 'wait', 'instinctive', 'donkey', 'squeamish', 'rainy',
    'craven', 'acceptable', 'husky', 'pollution', 'judicious', 'distribution', 'neck', 'left', 'collect', 'thankful', 'describe',
    'complex', 'transport', 'horses', 'hope', 'chemical', 'dress', 'idea', 'extend', 'laugh', 'event', 'route', 'hose', 'abundant',
    'insect', 'spectacular', 'whistle', 'home', 'vast', 'massive', 'grey', 'sail', 'lavish', 'word', 'coach', 'repair', 'squeak',
    'curious', 'beam', 'middle', 'obscene', 'efficacious', 'supreme', 'torpid', 'jazzy', 'linen', 'cause', 'synonymous', 'book', 'brave',
    'staking', 'weak', 'show', 'birds', 'barbarous', 'hilarious', 'injure', 'walk', 'screeching', 'frequent', 'wide', 'kiss', 'lonely',
    'quarrelsome', 'arm', 'flowers', 'surround', 'level', 'enjoy', 'calculate', 'reach', 'brother', 'grandiose', 'clammy', 'thunder',
    'pen', 'rake', 'whirl', 'sharp', 'fence', 'scissors', 'polish', 'recondite', 'brief', 'pig', 'ten', 'spell', 'coal', 'sidewalk',
    'straight', 'melted', 'ring', 'deadpan', 'nine', 'wound', 'use', 'switch', 'watch', 'meat', 'governor', 'lively', 'neat', 'dapper',
    'gate', 'rose', 'wealthy', 'psychedelic', 'slap', 'note', 'request', 'match', 'abashed', 'snail', 'tray', 'pump', 'disappear',
    'vegetable', 'wool', 'abstracted', 'impulse', 'fork', 'brake', 'shiny', 'team', 'coherent', 'dust', 'relieved', 'long', 'broad',
    'shop', 'innate', 'milk', 'mother', 'screw', 'cushion', 'listen', 'spot', 'willing', 'legs', 'clever', 'obsolete', 'coil', 'smoke',
    'call', 'men', 'purpose', 'bumpy', 'receipt', 'soothe', 'thinkable', 'launch', 'kittens', 'oceanic', 'dolls', 'jagged', 'fine',
    'start', 'muddled', 'want', 'develop', 'skillful', 'real', 'sisters', 'cooperative', 'retire', 'scarecrow', 'caring', 'chance',
    'search', 'visitor', 'stem', 'rabid', 'seed', 'endurable', 'cloistered', 'knife', 'cast', 'trouble', 'cold', 'brainy', 'admit',
    'base', 'multiply', 'escape', 'bike', 'frighten', 'large', 'pull', 'observant', 'stereotyped', 'dirty', 'tin', 'vague', 'celery',
    'hungry', 'best', 'difficult', 'burly', 'horse', 'flawless', 'fresh', 'inquisitive', 'illegal', 'omniscient', 'simplistic', 'selfish',
    'clean', 'hospital', 'encouraging', 'incompetent', 'right', 'learn', 'relation', 'spoil', 'amused', 'ruthless', 'squalid',
    'aftermath', 'increase', 'greasy', 'futuristic', 'shut', 'friendly', 'steep', 'range', 'faint', 'jail', 'wide-eyed', 'uptight',
    'erratic', 'eyes', 'cure', 'overwrought', 'muddle', 'bedroom', 'scale', 'rub', 'conscious', 'snake', 'box', 'command', 'slippery',
    'handsome', 'spy', 'tongue', 'unbecoming', 'magnificent', 'gold', 'resolute', 'face', 'childlike', 'approval', 'meaty', 'frog',
    'abrasive', 'rat', 'peel', 'office', 'panoramic', 'explode', 'selective', 'ahead', 'thaw', 'mean', 'odd', 'hate', 'window', 'somber',
    'guard', 'riddle', 'judge', 'flock', 'black', 'amusement', 'bikes', 'milk', 'sock', 'historical', 'tawdry', 'bare', 'mitten', 'harsh',
    'street', 'unequal', 'five', 'zinc', 'faulty', 'messy', 'thoughtful', 'spicy', 'oval', 'telephone', 'decisive', 'teeny', 'fix',
    'outstanding', 'excuse', 'abject', 'print', 'receive', 'jump', 'knock', 'ubiquitous', 'anxious', 'fill', 'shrug', 'ossified',
    'penitent', 'dry', 'abaft', 'uncle', 'voiceless', 'spray', 'town', 'aspiring', 'testy', 'bed', 'likeable', 'breezy', 'jumpy', 'talk',
    'powerful', 'various', 'crawl', 'lacking', 'lethal', 'baby', 'sore', 'mourn', 'behave', 'pass', 'mark', 'summer', 'cause',
    'destruction', 'stale', 'basin', 'embarrass', 'rob', 'income', 'overjoyed', 'aback', 'spark', 'air', 'worthless', 'hospitable',
    'dynamic', 'push', 'nervous', 'dark', 'chin', 'shock', 'frame', 'dojo');


  CommonCurrencies_US : array[0..32] of string = (
    // América
    'US Dollar',              // Estados Unidos
    'Canadian Dollar',        // Canadá
    'Mexican Peso',           // México
    'Brazilian Real',         // Brasil
    'Argentine Peso',         // Argentina
    'Chilean Peso',           // Chile
    'Colombian Peso',         // Colombia
    'Peruvian Nuevo Sol',     // Perú
    'Venezuelan Bolívar',     // Venezuela
    'Uruguayan Peso',         // Uruguay
    'Paraguayan Guarani',     // Paraguay
    'Bolivian Boliviano',     // Bolivia
    'Ecuadorian Dollar',      // Ecuador (usa el dólar estadounidense)
    'Costa Rican Colon',      // Costa Rica
    'Panamanian Balboa',      // Panamá (usa el dólar estadounidense)
    'Honduran Lempira',       // Honduras
    'Guatemalan Quetzal',     // Guatemala
    'Nicaraguan Cordoba',     // Nicaragua
    'Salvadoran Colon',       // El Salvador (usa el dólar estadounidense)
    'Dominican Peso',         // República Dominicana
    'Haitian Gourde',         // Haití
    'Jamaican Dollar',        // Jamaica
    'Bahamian Dollar',        // Bahamas
    'Barbadian Dollar',       // Barbados
    'Trinidad and Tobago Dollar', // Trinidad y Tobago
    'Guyana Dollar',          // Guyana
    'Cuban Peso',             // Cuba
    'Aruban Florin',          // Aruba

    // Europa
    'Euro',                   // Zona Euro (19 países)
    'Pound Sterling',         // Reino Unido
    'Swiss Franc',            // Suiza
    'Russian Ruble',          // Rusia
    'Ukrainian Hryvnia'      // Ucrania
  );


class function TDataGenerator.GetRandomElement(const List : array of string) : string;
begin
  Result := List[Random(Length(List))];
end;

// Función para verificar si una cadena termina con un sufijo específico
function EndsWith(const Str, Suffix : string) : Boolean;
var
  StrLength, SuffixLength : Integer;
begin
  StrLength    := Length(Str);
  SuffixLength := Length(Suffix);

  if SuffixLength > StrLength then
    Result := False
  else
    Result := Copy(Str, StrLength - SuffixLength + 1, SuffixLength) = Suffix;
end;

// Función para verificar si un nombre está en una lista específica
function IsInArray(const Name : string; const Arr : array of string) : Boolean;
var
  I : Integer;
  LowerName : string;
begin
  Result    := False;
  LowerName := LowerCase(Name);

  for I:= Low(Arr) to High(Arr) do
    if LowerName = LowerCase(Arr[I]) then
      begin
        Result := True;
        Exit;
      end;
end;

// Función para extraer el último componente de un nombre compuesto
function GetLastNameComponent(const Name : string) : string;
var
  I, LastSpacePos : Integer;
begin
  // Buscar la última posición de un espacio o guión
  LastSpacePos := 0;
  for I := 1 to Length(Name) do
    begin
      if (Name[I] = ' ') or (Name[I] = '-') then
        LastSpacePos := I;
    end;

  if LastSpacePos > 0 then
    Result := Copy(Name, LastSpacePos + 1, Length(Name) - LastSpacePos)
  else
    Result := Name;
end;

// Función para detectar el sexo basado en el nombre
function DetectSex(const FirstName : string; Locale : TDataLocale) : string;
var
  LastChar : Char;
  NameLower, LastComponent : string;
begin
  // Extraer el último componente del nombre (para nombres compuestos)
  LastComponent := GetLastNameComponent(FirstName);
  NameLower     := LowerCase(LastComponent);

  // Verificar si el nombre está en las listas de nombres femeninos o masculinos
  case Locale of
    dlLatino :
      begin
        if IsInArray(NameLower, Nombres_Femeninos_ES) then
          Exit('Femenino');
        if IsInArray(NameLower, Nombres_Masculinos_ES) then
          Exit('Masculino');
      end;
    dlUS :
      begin
        if IsInArray(NameLower, Nombres_Femeninos_US) then
          Exit('Female');
        if IsInArray(NameLower, Nombres_Masculinos_US) then
          Exit('Male');
      end;
  end;

  // Verificar listas de excepciones
  case Locale of
    dlLatino :
      begin
        if IsInArray(NameLower, ExcepcionesMasculinas_ES) then
          Exit('Masculino');
        if IsInArray(NameLower, ExcepcionesFemeninas_ES) then
          Exit('Femenino');
      end;
    dlUS :
      begin
        if IsInArray(NameLower, ExcepcionesMasculinas_US) then
          Exit('Male');
        if IsInArray(NameLower, ExcepcionesFemeninas_US) then
          Exit('Female');
      end;
  end;

  // Si no hay excepciones, aplicar reglas de sufijos
  if Length(NameLower) > 0 then
    LastChar := NameLower[Length(NameLower)]
  else
    LastChar := #0;

  case Locale of
    dlLatino :
      if LastChar = 'a' then
        Result := 'Femenino'
      else
        Result := 'Masculino';

    dlUS :
      if (LastChar = 'a')
      or EndsWith(NameLower, 'lyn')
      or EndsWith(NameLower, 'ie')
      or EndsWith(NameLower, 'ey')
      or EndsWith(NameLower, 'elle') then
        Result := 'Female'
      else
        Result := 'Male';
  else
    Result := 'Desconocido';
  end;
end;

function CalcularEdad(FechaNacimiento : TDate) : Word;
var
  Hoy : TDate;
  AnioNacimiento, MesNacimiento, DiaNacimiento : Word;
  AnioActual, MesActual, DiaActual : Word;
begin
  Hoy := Date;
  DecodeDate(FechaNacimiento, AnioNacimiento, MesNacimiento, DiaNacimiento);
  DecodeDate(Hoy, AnioActual, MesActual, DiaActual);

  Result := AnioActual - AnioNacimiento;

  // Si el cumpleaños aún no ha ocurrido este año, restamos 1 a la edad
  if (MesActual < MesNacimiento)
  or ((MesActual = MesNacimiento) and (DiaActual < DiaNacimiento)) then
    Dec(Result);
end;

// Función unificada para generar una persona aleatoria
class function TDataGenerator.GetRandomPerson(Locale : TDataLocale; Gender : TGender = genderAny; YearOfBirthStart : Word = 1950; YearOfBirthEnd : Word = 1990) : TPerson;
const
  MaritalStatus_M : array[1..4] of string = ('Casado', 'Soltero', 'Divorciado','Viudo');
  MaritalStatus_F : array[1..4] of string = ('Casada', 'Soltera', 'Divorciada','Viuda');
  MaritalStatus_US : array[1..4] of string = ('Married', 'Single', 'Divorced', 'Widow');

var
  FirstName : string;
  SelectedGender : TGender;
  idx : Integer;
begin
  if YearOfBirthStart >= YearOfBirthEnd then
    begin
      raise Exception.Create('Año inicial de nacimiento no puede ser mayor ni igual que Año final de nacimiento');
    end;

  // Determinar el género si no se especificó
  if Gender = genderAny then
    SelectedGender := TGender(Random(2) + 1) // genderMale o genderFemale
  else
    SelectedGender := Gender;

  // Seleccionar un nombre aleatorio según el idioma y género
  case Locale of
    dlLatino :
      begin
        if SelectedGender = genderMale then
          begin
            idx       := Random(Length(Nombres_Masculinos_ES));
            FirstName := Nombres_Masculinos_ES[idx];
          end
        else
          begin
            idx       := Random(Length(Nombres_Femeninos_ES));
            FirstName := Nombres_Femeninos_ES[idx];
          end;
      end;

    dlUS :
      begin
        if SelectedGender = genderMale then
          begin
            idx       := Random(Length(Nombres_Masculinos_US));
            FirstName := Nombres_Masculinos_US[idx];
          end
        else
          begin
            idx       := Random(Length(Nombres_Femeninos_US));
            FirstName := Nombres_Femeninos_US[idx];
          end;
      end;
  end;

  // Asignar el nombre generado
  Result.FirstName := FirstName;

  // Obtener un apellido aleatorio según el idioma
  case Locale of
    dlLatino : Result.LastName := GetRandomElement(Apellidos_ES);
    dlUS     : Result.LastName := GetRandomElement(Apellidos_US);
  else
    Result.LastName := '';
  end;

  // Completar los demás campos
  Result.FullName := Result.FirstName + ' ' + Result.LastName;
  Result.Email    := GenerateEmailFromName(Result.FirstName, Result.LastName);

  // Asignar el sexo basado en el nombre (utilizando la función de detección)
  Result.Sex := DetectSex(Result.FirstName, Locale);

  //Creamos la fecha de nacimiento dentro de un rango especifico
  Result.Birthdate := GenerateRandomRangeDate(YearOfBirthStart, YearOfBirthEnd);

  //Creamos la edad a partir de la fecha de nacimiento
  Result.Age := CalcularEdad(Result.Birthdate);

  // Aqui determinamos el estado civil de acuerdo al sexo y a la localización
  case Locale of
    dlLatino : begin
                 case SelectedGender of
                   genderAny    : begin
                                    if Result.Sex = 'Masculino' then
                                      Result.MaritalStatus := GetRandomElement(MaritalStatus_M)
                                    else
                                      Result.MaritalStatus := GetRandomElement(MaritalStatus_F);
                                  end;

                   genderMale   : Result.MaritalStatus := GetRandomElement(MaritalStatus_M);
                   genderFemale : Result.MaritalStatus := GetRandomElement(MaritalStatus_F);
                 end;
               end;

    dlUS     : begin
                 Result.MaritalStatus := GetRandomElement(MaritalStatus_US);
               end;

  end;

end;

class function TDataGenerator.GenerateRandomPhoneNumber(Locale : TDataLocale) : string;
type
  TPaisLatam = record
    Codigo      : string;
    FormatoFijo : Boolean;
    AreaCodes   : array of string;
  end;

const
  PAISES_LATAM : array[1..12] of TPaisLatam = (
    (Codigo: '+52'; FormatoFijo: False; AreaCodes: []), // México
    (Codigo: '+54'; FormatoFijo: False; AreaCodes: []), // Argentina
    (Codigo: '+55'; FormatoFijo: False; AreaCodes: []), // Brasil
    (Codigo: '+56'; FormatoFijo: False; AreaCodes: []), // Chile
    (Codigo: '+57'; FormatoFijo: False; AreaCodes: []), // Colombia
    (Codigo: '+58'; FormatoFijo: False; AreaCodes: []), // Venezuela
    (Codigo: '+51'; FormatoFijo: False; AreaCodes: []), // Perú
    (Codigo: '+593'; FormatoFijo: False; AreaCodes: []), // Ecuador
    (Codigo: '+598'; FormatoFijo: False; AreaCodes: []), // Uruguay
    (Codigo: '+502'; FormatoFijo: False; AreaCodes: []), // Guatemala
    (Codigo: '+1'; FormatoFijo: True; AreaCodes: ['809', '829', '849']), // República Dominicana
    (Codigo: '+1'; FormatoFijo: True; AreaCodes: ['787', '939']) // Puerto Rico
  );

begin
  if Locale = dlUS then
    begin
      Result := Format('+1 (%d%d%d) %d%d%d-%d%d%d%d',
                [Random(7)+2, Random(10), Random(10),
                Random(10), Random(10), Random(10),
                Random(10), Random(10), Random(10), Random(10)]);
    end
  else // LATAM
    begin
      var Pais := PAISES_LATAM[Random(Length(PAISES_LATAM))+1];

      if Pais.FormatoFijo then
        begin
          // Formato para países que usan el estilo (AAA) XXX-XXXX
          var AreaCode := Pais.AreaCodes[Random(Length(Pais.AreaCodes))];
          Result := Format('(%s) %d%d%d-%d%d%d%d', [AreaCode,
             Random(10), Random(10), Random(10),
             Random(10), Random(10), Random(10), Random(10)]);
        end
      else
        begin
          // Formato para otros países de LATAM
          Result := Pais.Codigo + ' ';
          for var I := 1 to 8 + Random(3) do
            Result := Result + IntToStr(Random(10));
        end;
    end;
end;

class function TDataGenerator.GenerateRandomPhoneNumberType(Locale : TDataLocale) : string;
const
  PhoneNumberTypes_ES : array[0..4] of string = ('Celular', 'Fax', 'Casa', 'Móvil', 'Trabajo');
  PhoneNumberTypes_US : array[0..4] of string = ('Cell', 'Fax', 'Home', 'Mobile', 'Work');
begin
  case Locale of
    dlLatino : Result := PhoneNumberTypes_ES[Random(Length(PhoneNumberTypes_ES))];
    dlUS     : Result := PhoneNumberTypes_US[Random(Length(PhoneNumberTypes_US))];
  else
    Result := '';
  end;

end;

class function TDataGenerator.GenerateRandomHobbies(Locale : TDataLocale) : string;
begin
  case Locale of
    dlLatino : Result := PASATIEMPOS_ES[Random(Length(PASATIEMPOS_ES))];
    dlUS     : Result := PASATIEMPOS_US[Random(Length(PASATIEMPOS_US))];
  else
    Result := '';
  end;

end;

class function TDataGenerator.GenerateRandomJobTitle(Locale : TDataLocale) : string;
begin
  case Locale of
    dlLatino : Result := GetRandomElement(Titulos_ES);
    dlUS     : Result := GetRandomElement(Titulos_US);
  else
    Result := '';
  end;
end;

class function TDataGenerator.GenerateRandomCompany(Locale : TDataLocale; UsarPrefijo : Boolean = True;
                                                    UsarIndustria : Boolean = True; UsarSufijo : Boolean = True) : string;

  //La función ElegirAleatorio selecciona un elemento aleatorio de un array.
  function ElegirAleatorio(const Items : array of string) : string;
  begin
    Result := Items[RandomRange(0, Length(Items))];
  end;

var
  Prefijo, Industria, Sufijo : string;
begin
  // Genera las partes según los parámetros y el idioma seleccionado
  if UsarPrefijo then
    case Locale of
      dlUS     : Prefijo := ElegirAleatorio(PREFIXES_US) + ' ';
      dlLatino : Prefijo := ElegirAleatorio(PREFIXES_ES) + ' ';
    end
  else
    Prefijo := '';

  if UsarIndustria then
    case Locale of
      dlUS :
        if Random < 0.5 then
          Industria := ElegirAleatorio(INDUSTRIES_US)
        else
          Industria := ElegirAleatorio(INDUSTRIES2_US);
      dlLatino :
        if Random < 0.5 then
          Industria := ElegirAleatorio(INDUSTRIES_ES)
        else
          Industria := ElegirAleatorio(INDUSTRIES2_ES);
    end
  else
    Industria := '';

  if UsarSufijo then
    case Locale of
      dlUS     : Sufijo := ' ' + ElegirAleatorio(SUFFIXES_US);
      dlLatino : Sufijo := ' ' + ElegirAleatorio(SUFFIXES_ES);
    end
  else
    Sufijo := '';

  // Componer el nombre personalizado
  Result := Prefijo + Industria + Sufijo;
  Result := Trim(Result); // Eliminar espacios extras
end;

class function TDataGenerator.GenerateRandomDepartment(Locale : TDataLocale) : string;
begin
  case Locale of
    dlLatino : Result := GetRandomElement(Departamentos_ES);
    dlUS     : Result := GetRandomElement(Departamentos_US);
  else
    Result := '';
  end;
end;

class function TDataGenerator.GenerateRandomSector(Locale : TDataLocale) : string;
begin
  case Locale of
    dlLatino : Result := GetRandomElement(Sectores_ES);
    dlUS     : Result := GetRandomElement(Sectores_US);
  else
    Result := '';
  end;
end;

class function TDataGenerator.GenerateRandomOccupation(Locale : TDataLocale) : string;
begin
  case Locale of
    dlLatino : Result := GetRandomElement(Ocupaciones_ES);
    dlUS     : Result := GetRandomElement(Ocupaciones_US);
  else
    Result := '';
  end;
end;

//ESTA FUNCION SOLO CREA EMAIL A PARTIR DE UN NOMBRE Y UN APELLIDO, EJ : JUAN PEREZ
class function TDataGenerator.GenerateEmailFromName(const FirstName, LastName : string) : string;
const
  Providers : array[1..10] of string = ('hubspot.com', 'gmail.com',
                                        'protonmail.com', 'icloud.com',
                                        'zohomail.com', 'outlook.com',
                                        'mailbox.org', 'yahoo.com',
                                        'bluehost.com', 'rackspace.com');
var
  LocalPart, Domain : string;
  RandomNumber : Integer;
begin
  // Generar número aleatorio entre 20 y 80
  RandomNumber := Random(61) + 20;

  // Crear la parte local del email
  LocalPart := LowerCase(FirstName + Copy(LastName, 1, 1) + IntToStr(RandomNumber));

  // Seleccionar dominio aleatorio
  Domain := Providers[Random(Length(Providers)) + 1];

  // Combinar para formar el email completo
  Result := LocalPart + '@' + Domain;
end;

{ ESTA FUNCION CREA EL EMAIL MANEJANDO NOMBRES Y APELLIDOS COMPUESTOS.
  EJ : JUAN MANUEL PÉREZ QUINTANILLA }
class function TDataGenerator.GenerateEmailFromCompoundName(const FullName, FullLastName : string) : string;
const
  Providers : array[1..10] of string = (
    'hubspot.com', 'gmail.com', 'protonmail.com', 'icloud.com', 'zohomail.com',
    'outlook.com', 'mailbox.org', 'yahoo.com', 'bluehost.com', 'rackspace.com');
var
  LocalPart, Domain : string;
  Names, LastNames : TArray<string>;
  EmailName, LastNameInitials : string;
  RandomNumber : Integer;
  I : Integer;
begin
  // Separar nombres y apellidos
  Names     := FullName.Split([' ']);
  LastNames := FullLastName.Split([' ']);

  // Construir la primera parte del email usando el primer nombre
  EmailName := Names[0];

  // Si hay un segundo nombre, añadir su inicial
  if Length(Names) > 1 then
    EmailName := EmailName + LowerCase(Copy(Names[1], 1, 1));

  // Construir iniciales de apellidos
  LastNameInitials := '';
  for I := 0 to Length(LastNames) - 1 do
    LastNameInitials := LastNameInitials + LowerCase(Copy(LastNames[I], 1, 1));

  // Generar número aleatorio entre 20 y 80
  RandomNumber := Random(61) + 20;

  // Crear la parte local del email
  LocalPart := LowerCase(EmailName + LastNameInitials + IntToStr(RandomNumber));

  // Seleccionar dominio aleatorio
  Domain := Providers[Random(Length(Providers)) + 1];

  // Combinar para formar el email completo
  Result := LocalPart + '@' + Domain;
end;

class function TDataGenerator.GenerateUserName(Name : string) : string;
var
  UsuarioBase              : string;
  NumeroAleatorio          : Integer;
  PosicionCaracterEspecial : Integer;
  CaracteresEspeciales     : array of Char; // Array dinámico de caracteres
  CaracterEspecial         : Char;
  Intento                  : Integer;
  EsValido                 : Boolean;
  I                        : Integer;
  EsCaracterEspecial       : Boolean;
begin
  PosicionCaracterEspecial := 0;

  // Definir los caracteres especiales que se pueden usar
  CaracteresEspeciales := ['.', '_']; // Puedes agregar más si lo deseas

  // Eliminar espacios en blanco y convertir a minúsculas
  UsuarioBase := LowerCase(StringReplace(Name, ' ', '', [rfReplaceAll]));

  // Generar un número aleatorio entre 100 y 999
  Randomize;
  NumeroAleatorio := Random(900) + 100;

  // Seleccionar un carácter especial aleatorio del array
  CaracterEspecial := CaracteresEspeciales[Random(Length(CaracteresEspeciales))];

  // Intentar insertar el carácter especial en una posición válida
  EsValido := False;
  Intento  := 0;
  while (not EsValido) and (Intento < 100) do // Evitar bucles infinitos
  begin
    // Elegir una posición aleatoria para insertar el carácter especial
    PosicionCaracterEspecial := Random(Length(UsuarioBase)) + 1;

    // Verificar que la posición no tenga un carácter especial adyacente
    EsCaracterEspecial := False;

    // Verificar si el carácter adyacente es un carácter especial
    for I := Low(CaracteresEspeciales) to High(CaracteresEspeciales) do
    begin
      if (PosicionCaracterEspecial > 1)
      and (UsuarioBase[PosicionCaracterEspecial - 1] = CaracteresEspeciales[I]) then
        EsCaracterEspecial := True;

      if (PosicionCaracterEspecial <= Length(UsuarioBase))
      and (UsuarioBase[PosicionCaracterEspecial] = CaracteresEspeciales[I]) then
        EsCaracterEspecial := True;
    end;

    // Si no hay caracteres especiales adyacentes, la posición es válida
    if not EsCaracterEspecial then
      EsValido := True;

    // Incrementar el contador de intentos
    Inc(Intento);
  end;

  // Si se encontró una posición válida, insertar el carácter especial
  if EsValido then
    Insert(CaracterEspecial, UsuarioBase, PosicionCaracterEspecial)
  else
    // Si no se encontró una posición válida, no insertar ningún carácter especial
    UsuarioBase := UsuarioBase;

  // Combinar el nombre base con el número aleatorio
  Result := UsuarioBase + IntToStr(NumeroAleatorio);
end;

class function TDataGenerator.GetCountryAndCapital(Locale : TDataLocale; Index : Integer) : TCountryCapital;

//DECLARAMOS UN ARRAY DE ACUERDO AL TIPO DEFINIDO Y LO INICIALIZAMOS
const
  Pais : array[0..34] of TCountryCapital = (
   (Country : 'Venezuela'; Capital : 'Caracas'),
   (Country : 'Argentina'; Capital : 'Buenos Aires'),
   (Country : 'Estados Unidos'; Capital : 'Washington'),
   (Country : 'México'; Capital : 'Ciudad de México'),
   (Country : 'Brasil'; Capital : 'Brasilia'),
   (Country : 'Colombia'; Capital : 'Bogotá'),
   (Country : 'Perú'; Capital : 'Lima'),
   (Country : 'Chile'; Capital : 'Santiago de Chile'),
   (Country : 'Ecuador'; Capital : 'Quito'),
   (Country : 'Uruguay'; Capital : 'Montevideo'),
   (Country : 'Canadá'; Capital : 'Ottawa'),
   (Country : 'Paraguay'; Capital : 'Asunción'),
   (Country : 'Bolivia'; Capital : 'Sucre'),
   (Country : 'Guatemala'; Capital : 'Ciudad de Guatemala'),
   (Country : 'Cuba'; Capital : 'La Habana'),
   (Country : 'España'; Capital : 'Madrid'),
   (Country : 'Portugal'; Capital : 'Lisboa'),
   (Country : 'Francia'; Capital : 'París'),
   (Country : 'Alemania'; Capital : 'Berlín'),
   (Country : 'Italia'; Capital : 'Roma'),
   (Country : 'Reino Unido'; Capital : 'Londres'),
   (Country : 'Holanda'; Capital : 'Ámsterdam'),
   (Country : 'Bélgica'; Capital : 'Bruselas'),
   (Country : 'Suiza'; Capital : 'Berna'),
   (Country : 'Austria'; Capital : 'Viena'),
   (Country : 'Grecia'; Capital : 'Atenas'),
   (Country : 'Suecia'; Capital : 'Estocolmo'),
   (Country : 'Noruega'; Capital : 'Oslo'),
   (Country : 'Dinamarca'; Capital : 'Copenhague'),
   (Country : 'Finlandia'; Capital : 'Helsinki'),
   (Country : 'Polonia'; Capital : 'Varsovia'),
   (Country : 'República Checa'; Capital : 'Praga'),
   (Country : 'Hungría'; Capital : 'Budapest'),
   (Country : 'Irlanda'; Capital : 'Dublín'),
   (Country : 'Rusia'; Capital : 'Moscú'));

  CountryUS : array[0..34] of TCountryCapital = (
    (Country : 'United States'; Capital : 'New York City'),
    (Country : 'United States'; Capital : 'Los Angeles'),
    (Country : 'United States'; Capital : 'Chicago'),
    (Country : 'United States'; Capital : 'Houston'),
    (Country : 'United States'; Capital : 'Phoenix'),
    (Country : 'United States'; Capital : 'Philadelphia'),
    (Country : 'United States'; Capital : 'San Antonio'),
    (Country : 'United States'; Capital : 'San Diego'),
    (Country : 'United States'; Capital : 'Dallas'),
    (Country : 'United States'; Capital : 'San Francisco'),
    (Country : 'United States'; Capital : 'Indianapolis'),
    (Country : 'United States'; Capital : 'Charlotte'),
    (Country : 'United States'; Capital : 'Seattle'),
    (Country : 'United States'; Capital : 'Denver'),
    (Country : 'United States'; Capital : 'Washington D.C.'),
    (Country : 'United States'; Capital : 'Boston'),
    (Country : 'United States'; Capital : 'Detroit'),
    (Country : 'United States'; Capital : 'Oklahoma City'),
    (Country : 'United States'; Capital : 'Portland'),
    (Country : 'United States'; Capital : 'Las Vegas'),
    (Country : 'United States'; Capital : 'Milwaukee'),
    (Country : 'United States'; Capital : 'Baltimore'),
    (Country : 'United States'; Capital : 'Sacramento'),
    (Country : 'United States'; Capital : 'Kansas City'),
    (Country : 'United States'; Capital : 'Miami'),
    (Country : 'United States'; Capital : 'Oakland'),
    (Country : 'United States'; Capital : 'Minneapolis'),
    (Country : 'United States'; Capital : 'New Orleans'),
    (Country : 'United States'; Capital : 'Cincinnati'),
    (Country : 'United States'; Capital : 'Tampa'),
    (Country : 'United States'; Capital : 'Orlando'),
    (Country : 'United States'; Capital : 'St. Louis'),
    (Country : 'United States'; Capital : 'Pittsburgh'),
    (Country : 'United States'; Capital : 'Cleveland'),
    (Country : 'United States'; Capital : 'Atlanta'));

begin
  case Locale of
    dlLatino : begin
                 Result.Country := Pais[Index].Country;
                 Result.Capital := Pais[Index].Capital;
               end;

    dlUS     : begin
                 Result.Country := CountryUS[Index].Country;
                 Result.Capital := CountryUS[Index].Capital;
               end;
  end;

end;

class function TDataGenerator.GetRandomAddress(Locale : TDataLocale; Index : Integer) : string;
const
  DireccionesEEUU : array[0..29] of string = (
    '123 Oak Street, Boston, MA 02108',
    '456 Maple Avenue, Los Angeles, CA 90012',
    '789 Pine Road, Chicago, IL 60601',
    '321 Cedar Lane, Miami, FL 33101',
    '654 Elm Drive, Seattle, WA 98101',
    '987 Birch Boulevard, Denver, CO 80201',
    '147 Washington Street, New York, NY 10007',
    '258 Lincoln Avenue, San Francisco, CA 94102',
    '369 Jefferson Road, Austin, TX 78701',
    '741 Roosevelt Drive, Portland, OR 97201',
    '852 Madison Court, Atlanta, GA 30301',
    '963 Adams Place, Philadelphia, PA 19101',
    '159 Monroe Street, Las Vegas, NV 89101',
    '357 Jackson Avenue, Phoenix, AZ 85001',
    '486 Harrison Road, Houston, TX 77001',
    '753 Wilson Lane, Detroit, MI 48201',
    '951 Taylor Street, Minneapolis, MN 55401',
    '264 Grant Avenue, Dallas, TX 75201',
    '375 Central Park West, New York, NY 10024',
    '159 Beacon Street, Boston, MA 02116',
    '753 Market Street, San Francisco, CA 94103',
    '846 Broadway, Nashville, TN 37201',
    '937 Peachtree Street, Atlanta, GA 30309',
    '264 Michigan Avenue, Chicago, IL 60601',
    '375 South Beach Drive, Miami Beach, FL 33139',
    '486 Rodeo Drive, Beverly Hills, CA 90210',
    '597 Bourbon Street, New Orleans, LA 70112',
    '681 State Street, Salt Lake City, UT 84111',
    '792 Pearl Street, Boulder, CO 80302',
    '835 5th Avenue, San Diego, CA 92101');

  DireccionesLatam : array[0..29] of string = (
    'Av. 9 de Julio 1234',
    'Rua Augusta 567',
    'Av. Providencia 789',
    'Calle 82 #11-75',
    'Paseo de la Reforma 222',
    'Av. Javier Prado 333',
    'Av. 18 de Julio 1456',
    'Av. Francisco de Miranda 852',
    'Av. Corrientes 456',
    'Rua Oscar Freire 951',
    'Av. Kennedy 753',
    'Carrera 7 #71-21',
    'Av. Insurgentes Sur 586',
    'Av. Arequipa 654',
    'Rambla República 789',
    'Av. Libertador 951',
    'Calle Florida 753',
    'Av. Paulista 847',
    'Av. Las Condes 159',
    'Calle 100 #19-61',
    'Av. Chapultepec 753',
    'Av. Larco 441, Miraflores',
    'Av. Luis Alberto de Herrera 952',
    'Av. Las Mercedes 123',
    'Av. Santa Fe 1234',
    'Rua João Cachoeira 369',
    'Av. Apoquindo 456',
    'Av. El Poblado #123',
    'Av. Presidente Masaryk 111',
    'Av. José Pardo 258, Miraflores');

begin
  case Locale of
    dlLatino : Result := DireccionesLatam[Index];
    dlUS     : Result := DireccionesEEUU[Index];
  end;

end;

//FUNCION QUE OBTIENE LOS ESTADOS Y SU CIUDAD DE LOS ESTADOS UNIDOS
class function TDataGenerator.GetStateAndCityUSA(Index : Integer) : TUSCiudad;
const
  USCityData : array[0..49] of TUSCiudad = (
    (EStado: 'New York'; Ciudad: 'New York City'),
    (EStado: 'California'; Ciudad: 'Los Angeles'),
    (EStado: 'Illinois'; Ciudad: 'Chicago'),
    (EStado: 'Texas'; Ciudad: 'Houston'),
    (EStado: 'Arizona'; Ciudad: 'Phoenix'),
    (EStado: 'Pennsylvania'; Ciudad: 'Philadelphia'),
    (EStado: 'Texas'; Ciudad: 'San Antonio'),
    (EStado: 'California'; Ciudad: 'San Diego'),
    (EStado: 'Texas'; Ciudad: 'Dallas'),
    (EStado: 'California'; Ciudad: 'San Jose'),
    (EStado: 'Texas'; Ciudad: 'Austin'),
    (EStado: 'Florida'; Ciudad: 'Jacksonville'),
    (EStado: 'California'; Ciudad: 'San Francisco'),
    (EStado: 'Ohio'; Ciudad: 'Columbus'),
    (EStado: 'Texas'; Ciudad: 'Fort Worth'),
    (EStado: 'Indiana'; Ciudad: 'Indianapolis'),
    (EStado: 'North Carolina'; Ciudad: 'Charlotte'),
    (EStado: 'Washington'; Ciudad: 'Seattle'),
    (EStado: 'Colorado'; Ciudad: 'Denver'),
    (EStado: 'District of Columbia'; Ciudad: 'Washington D.C.'),
    (EStado: 'Massachusetts'; Ciudad: 'Boston'),
    (EStado: 'Tennessee'; Ciudad: 'Nashville'),
    (EStado: 'Michigan'; Ciudad: 'Detroit'),
    (EStado: 'Oklahoma'; Ciudad: 'Oklahoma City'),
    (EStado: 'Oregon'; Ciudad: 'Portland'),
    (EStado: 'Nevada'; Ciudad: 'Las Vegas'),
    (EStado: 'Tennessee'; Ciudad: 'Memphis'),
    (EStado: 'Kentucky'; Ciudad: 'Louisville'),
    (EStado: 'Wisconsin'; Ciudad: 'Milwaukee'),
    (EStado: 'Maryland'; Ciudad: 'Baltimore'),
    (EStado: 'New Mexico'; Ciudad: 'Albuquerque'),
    (EStado: 'Arizona'; Ciudad: 'Tucson'),
    (EStado: 'California'; Ciudad: 'Sacramento'),
    (EStado: 'Missouri'; Ciudad: 'Kansas City'),
    (EStado: 'Colorado'; Ciudad: 'Colorado Springs'),
    (EStado: 'Florida'; Ciudad: 'Miami'),
    (EStado: 'North Carolina'; Ciudad: 'Raleigh'),
    (EStado: 'Virginia'; Ciudad: 'Virginia Beach'),
    (EStado: 'California'; Ciudad: 'Oakland'),
    (EStado: 'Minnesota'; Ciudad: 'Minneapolis'),
    (EStado: 'Oklahoma'; Ciudad: 'Tulsa'),
    (EStado: 'Louisiana'; Ciudad: 'New Orleans'),
    (EStado: 'Ohio'; Ciudad: 'Cincinnati'),
    (EStado: 'Florida'; Ciudad: 'Tampa'),
    (EStado: 'Florida'; Ciudad: 'Orlando'),
    (EStado: 'Missouri'; Ciudad: 'St. Louis'),
    (EStado: 'Pennsylvania'; Ciudad: 'Pittsburgh'),
    (EStado: 'Ohio'; Ciudad: 'Cleveland'),
    (EStado: 'Hawaii'; Ciudad: 'Honolulu'),
    (EStado: 'Georgia'; Ciudad: 'Atlanta'));
begin
  Result.EStado := USCityData[Index].EStado;
  Result.Ciudad := USCityData[Index].Ciudad;
end;

class function TDataGenerator.GenerateRandomDate(StartDate, EndDate : TDate) : TDate;
var
  Range : Integer;
begin
  // Asegúrate de que StartDate sea menor que EndDate
  if StartDate > EndDate then
    begin
      StartDate := EndDate;
      EndDate   := StartDate;
    end;

  Range  := DaysBetween(EndDate, StartDate);
  Result := IncDay(StartDate, Random(Range + 1));
end;

class function TDataGenerator.GenerateRandomRangeDate(StartYear, EndYear : Integer) : TDate;
var
  StartDate, EndDate : TDate;
  Range : Integer;
begin
  // Generar las fechas de inicio y fin basadas en los años proporcionados
  StartDate := EncodeDate(StartYear, 1, 1);  // 1 de enero del año inicial
  EndDate   := EncodeDate(EndYear, 12, 31);  // 31 de diciembre del año final

  // Asegúrate de que StartDate sea menor que EndDate
  if StartDate > EndDate then
    begin
      StartDate := EndDate;
      EndDate   := StartDate;
    end;

  Range  := DaysBetween(EndDate, StartDate);
  Result := IncDay(StartDate, Random(Range + 1));
end;

{
Esta función genera una fecha aleatoria a partir de un año específico.
Parámetros de entrada :
InitialYear : El año inicial desde donde empezar.
YearsSpan   : El número de años hacia adelante para generar la fecha.

Ejemplo de uso : GenerateRandomDate(2020, 3);
La función podrá generar fechas en los años: 2020, 2021, o 2022
Esto es porque Random(YearsSpan) generará un número aleatorio entre 0 y 2

Otro ejemplo : GenerateRandomDate(2000, 10);
Podrás obtener fechas entre los años 2000 y 2009
Porque Random(10) dará un número entre 0 y 9

El parametro YearsSpan te permite controlar cuántos años hacia adelante,
a partir del año inicial, quieres que la función considere para generar la
fecha aleatoria.
}

class function TDataGenerator.GenerateRandomDate(const InitialYear : Word; YearsSpan : Word) : TDate;
const
  OneDay = OneHour * 24;
var
  RandomYear : Word;
  DaysInYear : Integer;
begin
  // Generar año aleatorio
  RandomYear := InitialYear + Random(YearsSpan);

  // Determinar si el año es bisiesto y ajustar los días del año
  if IsLeapYear(RandomYear) then
    DaysInYear := 366
  else
    DaysInYear := 365;

  // Crear fecha base (1 de enero del año aleatorio)
  Result := EncodeDate(RandomYear, 1, 1);

  // Añadir días aleatorios considerando si es año bisiesto
  Result := Result + (OneDay * Random(DaysInYear));
end;

class function TDataGenerator.GenerateRandomDateTime(StartDate, EndDate : TDateTime) : TDateTime;
var
  RandomDate, RandomTime : TDateTime;
begin
  // Asegúrate de que StartDate sea menor que EndDate
  if StartDate > EndDate then
    begin
      StartDate := EndDate;
      EndDate   := StartDate;
    end;

  RandomDate := StartDate + Random(DaysBetween(EndDate, StartDate) + 1);
  RandomTime := EncodeTime(Random(24), Random(60), Random(60), Random(1000));
  Result     := RandomDate + RandomTime;
end;

class function TDataGenerator.GenerateRandomTime(StartTime, EndTime : TTime) : TTime;
var
  MinutesRange, RandomMinutes : Integer;
begin
  // Asegúrate de que StartTime sea menor que EndTime
  if StartTime > EndTime then
    begin
      StartTime := EndTime;
      EndTime   := StartTime;
    end;

  MinutesRange  := MinutesBetween(EndTime, StartTime);
  RandomMinutes := Random(MinutesRange + 1);
  Result        := IncMinute(StartTime, RandomMinutes);
end;

class function TDataGenerator.RandomRangeDecimal(Min, Max : Double) : Double;
begin
  if Min >= Max then
    begin
      raise Exception.Create('Min no puede ser mayor ni igual que Max');
    end;

  Result := Min + Random * (Max - Min);
end;

class function TDataGenerator.RandomRangeInteger(const aFrom : Integer; aTo : Integer) : Integer;
begin
  if aFrom >= aTo then
    begin
      raise Exception.Create('FROM no puede ser mayor ni igual que TO');
    end;

  Result := RandomRange(aFrom, aTo);
end;

class function TDataGenerator.GenerateRandomDrugName(Locale : TDataLocale) : string;

  // PREFIJOS DE MEDICAMENTOS (INGLÉS)
  const DRUG_PREFIXES_EN : array[0..173] of string = (
    'Abe', 'Aca', 'Ari', 'Aci', 'Aco', 'Acti', 'Apro', 'Adi', 'Acy', 'Adel',
    'Aero', 'Af', 'Alfi', 'Alfu', 'Aller', 'Allo', 'Alpo', 'Ace', 'Amci', 'Amfo',
    'Anti', 'Azi', 'Ban', 'Bas', 'Bay', 'Beny', 'Beta', 'Bi', 'Bu', 'Bio',
    'Calci', 'Candi', 'Capto', 'Carvi', 'Cefa', 'Chlor', 'Ciclo', 'Cyclo', 'Clo',
    'Dox', 'Deco', 'Delta', 'Derma', 'Dermo', 'Dexa', 'Dexi', 'Dextro', 'Diclo',
    'Di', 'Doxa', 'Doxy', 'Duo', 'Dura', 'Dyna', 'Ebi', 'Eco', 'Ena', 'Endo',
    'Epi', 'Ery', 'Eto', 'Exo', 'Famo', 'Felo', 'Feno', 'Ferro', 'Fibra', 'Flo',
    'Flu', 'Furo', 'Gaba', 'Genta', 'Gyno', 'Halo', 'Hapa', 'Hepa', 'Herpe',
    'Hibi', 'Iru', 'Ibu', 'Inda', 'Indo', 'Infa', 'Influ', 'Inno', 'Inter',
    'Iodo', 'Ipro', 'Ire', 'Iri', 'Iso', 'Keto', 'Kita', 'Koni', 'Laxo', 'Laste',
    'Lefu', 'Levo', 'Lido', 'Lisi', 'Logo', 'Lo', 'Losa', 'Loxa', 'Lyo', 'Levo',
    'Meco', 'Medi', 'Meli', 'Melo', 'Mepa', 'Metro', 'Mico', 'Mini', 'Mira',
    'Mono', 'Moxi', 'Muco', 'Myko', 'Medro', 'Meto', 'Napo', 'Nata', 'Neo',
    'Neu', 'Nevo', 'Nito', 'Nora', 'Novo', 'Oflo', 'Ome', 'Osa', 'Oxa', 'Oxi',
    'Oxy', 'Pana', 'Panto', 'Para', 'Pento', 'Pipe', 'Poli', 'Poly', 'Pro',
    'Peri', 'Radi', 'Rami', 'Redu', 'Rena', 'Riba', 'Robi', 'Rythmo', 'Septo',
    'Serra', 'Sime', 'Syndo', 'Tamo', 'Tamsu', 'Teno', 'Tri', 'Tylo', 'Ulco',
    'Valco', 'Velo', 'Venla', 'Viro', 'Vita', 'Voma', 'Vove', 'Xylo', 'Zale',
    'Zapra', 'Zithro', 'Zyla', 'Zyto');

  // INFIJOS DE MEDICAMENTOS (INGLÉS)
  const DRUG_INFIXES_EN : array[0..34] of string = (
    'fa', 'pera', 'butam', 'carpam', 'chloride', 'hydro', 'thromy', 'peri',
    'sil', 'ta', 'tra', 'cur', 'lon', 'tam', 'tan', 'clo', 'con', 'zo', 'ma',
    'na', 'pa', 'dro', 'go', 'puri', 'dipi', 'si', 'son', 'sopro', 'spo', 'xa',
    'ni', 'oxe', 'zon', 'vir', 'mol');

  // SUFIJOS DE MEDICAMENTOS (INGLÉS)
  const DRUG_SUFFIXES_EN : array[0..42] of string = (
    'vant', 'tan', 'bid', 'muc', 'de', 'dex', 'dine', 'vir', 'que', 'non',
    'vase', 'tex', 'tec', 'sine', 'pin', 'ino', 'lat', 'rex', 'phane', 'zon',
    'zyl', 'pren', 'cept', 'fast', 'fen', 'nor', 'cin', 'ne', 'pos', 'nal',
    'lam', 'te', 'xol', 'xel', 'hex', 'lol', 'nide', 'dar', 'tad', 'zol',
    'liq', 'sol', 'ban');

  // Simulación de medicamentos reales en inglés
  const MEDICINAS_REALES_EN : array[0..49] of string = (
    'Acetaminophen', 'Ibuprofen', 'Aspirin', 'Amoxicillin', 'Omeprazole',
    'Loratadine', 'Diphenhydramine', 'Metformin', 'Atorvastatin', 'Lisinopril',
    'Insulin', 'Cetirizine', 'Diazepam', 'Clonazepam', 'Ranitidine',
    'Hand Sanitizer', 'Vitamin C', 'Multivitamin', 'Albuterol', 'Prednisone',
    'Diclofenac', 'Ketorolac', 'Naproxen', 'Ciprofloxacin', 'Levothyroxine',
    'Losartan', 'Amlodipine', 'Simvastatin', 'Furosemide', 'Propranolol',
    'Sertraline', 'Fluoxetine', 'Escitalopram', 'Paroxetine', 'Alprazolam',
    'Risperidone', 'Haloperidol', 'Metronidazole', 'Clindamycin', 'Esomeprazole',
    'Tylenol', 'Lactulose', 'Bisacodyl', 'Collagen', 'Melatonin',
    'Folic Acid', 'Calcium', 'Magnesium', 'Zinc', 'Vitamin D');


  // PREFIJOS DE MEDICAMENTOS (ESPAÑOL)
  const DRUG_PREFIXES_ES : array[0..49] of string = (
    'Aceta', 'Amox', 'Ator', 'Azit', 'Benz', 'Brom', 'Carba', 'Cefa', 'Ceti',
    'Cipro', 'Clari', 'Clinda', 'Clona', 'Clor', 'Dexa', 'Diaze', 'Diclo',
    'Dolo', 'Dorzo', 'Enala', 'Escita', 'Esomep', 'Espiro', 'Feno', 'Fluox',
    'Furose', 'Gabap', 'Hidro', 'Ibup', 'Indom', 'Keto', 'Lansa', 'Levo',
    'Lora', 'Losar', 'Mebe', 'Melox', 'Metro', 'Mino', 'Napro', 'Nifed',
    'Olme', 'Omep', 'Parox', 'Pred', 'Ranit', 'Salbu', 'Serta', 'Simva', 'Tramad');

  // INFIJOS DE MEDICAMENTOS (ESPAÑOL)
  const DRUG_INFIXES_ES : array[0..24] of string = (
    'min', 'cil', 'vasta', 'rom', 'cain', 'mazo', 'lol', 'zep', 'fen',
    'flox', 'tromi', 'micin', 'zep', 'hidro', 'meta', 'prof', 'acin',
    'pril', 'lopr', 'sart', 'cort', 'tad', 'cox', 'dop', 'ridol');

  // SUFIJOS DE MEDICAMENTOS (ESPAÑOL)
  const DRUG_SUFFIXES_ES : array[0..24] of string = (
    'ol', 'ina', 'tina', 'icina', 'azol', 'pam', 'aco', 'ona', 'ilo',
    'amol', 'anol', 'azina', 'oxina', 'axina', 'idina', 'asona', 'olol',
    'opril', 'astina', 'conazol', 'ozol', 'amina', 'atadina', 'etiazem', 'dipina');

  // Simulación de medicamentos reales en español
  const MEDICINAS_REALES_ES : array[0..49] of string = (
    'Paracetamol', 'Ibuprofeno', 'Aspirina', 'Amoxicilina', 'Omeprazol',
    'Loratadina', 'Dipirona', 'Metformina', 'Atorvastatina', 'Enalapril',
    'Insulina', 'Cetirizina', 'Diazepam', 'Clonazepam', 'Ranitidina',
    'Alcohol en gel', 'Vitamina C', 'Multivitamínicos', 'Salbutamol', 'Prednisona',
    'Diclofenaco', 'Ketorolaco', 'Naproxeno', 'Ciprofloxacina', 'Levotiroxina',
    'Losartán', 'Amlodipino', 'Simvastatina', 'Furosemida', 'Propranolol',
    'Sertralina', 'Fluoxetina', 'Escitalopram', 'Paroxetina', 'Alprazolam',
    'Risperidona', 'Haloperidol', 'Metronidazol', 'Clindamicina', 'Esomeprazol',
    'Acetaminofén', 'Lactulosa', 'Bisacodilo', 'Colágeno', 'Melatonina',
    'Ácido fólico', 'Calcio', 'Magnesio', 'Zinc', 'Vitamina D');


  // Función auxiliar para elegir un elemento aleatorio de un array
  function ChooseRandom(const Items : array of string) : string;
  begin
    Result := Items[RandomRange(0, Length(Items))];
  end;

var
  Prefix, Infix, Suffix : string;
  UseRealName : Boolean;
begin
  // 30% de probabilidad de usar un nombre real de medicamento
  UseRealName := Random < 0.3;

  case Locale of
    dlUS :
      begin
        if UseRealName then
          Result := ChooseRandom(MEDICINAS_REALES_EN)
        else
          begin
            Prefix := ChooseRandom(DRUG_PREFIXES_EN);
            Infix  := ChooseRandom(DRUG_INFIXES_EN);
            Suffix := ChooseRandom(DRUG_SUFFIXES_EN);
            Result := Prefix + Infix + Suffix;
          end;
      end;

    dlLatino :
      begin
        if UseRealName then
          Result := ChooseRandom(MEDICINAS_REALES_ES)
        else
          begin
            Prefix := ChooseRandom(DRUG_PREFIXES_ES);
            Infix  := ChooseRandom(DRUG_INFIXES_ES);
            Suffix := ChooseRandom(DRUG_SUFFIXES_ES);
            Result := Prefix + Infix + Suffix;
          end;
      end;
  end;
end;

class function TDataGenerator.GenerateRandomWord(Locale : TDataLocale) : string;
begin
  case Locale of
    dlLatino : Result := WORDS_ES[RandomRange(0, Length(WORDS_ES))];
    dlUS     : Result := WORDS_US[RandomRange(0, Length(WORDS_US))];
  end;
end;

class function TDataGenerator.GenerateRandomPhrase(Locale : TDataLocale; const aFrom : Integer = 0; aTo : Integer = 1000) : string;
var
  I, WordCount : Integer;
begin
  Result    := '';
  WordCount := RandomRange(aFrom, aTo);
  for I:= 1 to WordCount do
  begin
    Result := Result + GenerateRandomWord(Locale) + ' ';
  end;

  Result := Result.Trim;
  Result := UpCase(Result.Chars[0]) + Result.Substring(1) + '.';
end;

class function TDataGenerator.GenerateRandomString(Locale : TDataLocale; StrLength : Integer) : string;
const
  CharsUSA = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  CharsLATAM = 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyzáéíóúÁÉÍÓÚüÜàâãõçÀÂÃÕÇ';
var
  I : Integer;
  PossibleChars : string;
begin
  case Locale of
    dlLatino : PossibleChars := CharsLATAM;
    dlUS     : PossibleChars := CharsUSA;
  end;

  Result := '';
  for I := 1 to StrLength do
    Result := Result + PossibleChars[Random(Length(PossibleChars)) + 1];
end;

class function TDataGenerator.GenerateRandomPaymentMethod(Locale : TDataLocale) : string;
const
  PaymentMethods_ES : array[0..7] of string = ('Efectivo', 'Credito',
                                               'Tarjeta crédito',
                                               'Tarjeta débito', 'PayPal',
                                               'Cheque', 'Giro postal',
                                               'Transferencia bancaria');
  PaymentMethods_US : array[0..7] of string = ('Cash', 'Credit', 'Credit Card',
                                               'Debit Card', 'PayPal', 'Check',
                                               'Money order', 'Bank Transfer');
begin
  case Locale of
    dlLatino : Result := PaymentMethods_ES[Random(Length(PaymentMethods_ES))];
    dlUS     : Result := PaymentMethods_US[Random(Length(PaymentMethods_US))];
  end;

end;

class function TDataGenerator.GenerateCreditCard(Formateado : Boolean) : TCreditCard;
const
  CardTypes : array[0..4] of string = ('Mastercard','VISA','American Express',
                                       'Diners Club', 'Discover');
var
  CardLength, I, Sum, Digit : Integer;
  Prefix, Number, FormattedNumber : string;
begin
  // Tomo un tipo de tarjeta aleatoriamente
  Result.CardType := CardTypes[Random(Length(CardTypes))];

  // Asignar prefijo y longitud según el tipo de tarjeta
  if Result.CardType = 'Diners Club' then
    begin
      Prefix     := '36';
      CardLength := 14;
    end
  else if Result.CardType = 'Mastercard' then
    begin
      Prefix     := '51';
      CardLength := 16;
    end
  else if Result.CardType = 'Discover' then
    begin
      Prefix     := '6011';
      CardLength := 16;
    end
  else if Result.CardType = 'American Express' then
    begin
      Prefix     := '34';
      CardLength := 15;
    end
  else if Result.CardType = 'VISA' then
    begin
      Prefix     := '4';
      CardLength := 16;
    end
  else
    raise Exception.Create('Tipo de tarjeta no válido');

  // Generar los dígitos restantes (excepto el último)
  Number := Prefix;

  for I := Length(Prefix) + 1 to CardLength - 1 do
    Number := Number + IntToStr(Random(10));

  // Calcular el dígito de verificación (algoritmo de Luhn)
  Sum := 0;

  for I := 1 to CardLength - 1 do
  begin
    Digit := StrToInt(Number[I]);
    if I mod 2 = 1 then
      Digit := Digit * 2;
    if Digit > 9 then
      Digit := Digit - 9;
    Sum := Sum + Digit;
  end;

  // Calcular el dígito de verificación
  Digit  := (10 - (Sum mod 10)) mod 10;
  Number := Number + IntToStr(Digit);

  // Aplicar formato si se requiere
  if Formateado then
    begin
      if Result.CardType = 'Diners Club' then
        FormattedNumber := Copy(Number, 1, 4) + '-' + Copy(Number, 5, 6) + '-' + Copy(Number, 11, 4)
      else if Result.CardType = 'Mastercard' then
        FormattedNumber := Copy(Number, 1, 4) + '-' + Copy(Number, 5, 4) + '-' + Copy(Number, 9, 4) + '-' + Copy(Number, 13, 4)
      else if Result.CardType = 'Discover' then
        FormattedNumber := Copy(Number, 1, 4) + '-' + Copy(Number, 5, 4) + '-' + Copy(Number, 9, 4) + '-' + Copy(Number, 13, 4)
      else if Result.CardType = 'American Express' then
        FormattedNumber := Copy(Number, 1, 4) + '-' + Copy(Number, 5, 6) + '-' + Copy(Number, 11, 5)
      else if Result.CardType = 'VISA' then
        FormattedNumber := Copy(Number, 1, 4) + '-' + Copy(Number, 5, 4) + '-' + Copy(Number, 9, 4) + '-' + Copy(Number, 13, 4)
      else
        FormattedNumber := Number;

      Result.Number := FormattedNumber;
    end
  else
    Result.Number := Number;
end;

class function TDataGenerator.GenerateRandomCurrency(Locale : TDataLocale) : string;
begin
  case Locale of
    dlLatino : Result := CommonCurrencies_ES[Random(Length(CommonCurrencies_ES))];
    dlUS     : Result := CommonCurrencies_US[Random(Length(CommonCurrencies_US))];
  end;

end;

class function TDataGenerator.GenerateRandomProductName : string;
const
  Prefixes : array[0..28] of string = (
    'Com', 'Speak', 'Sub', 'Con', 'Mic', 'Tweet', 'Read', 'Tab', 'Cab', 'Tab',
    'Bi', 'Te', 'Mono', 'Print', 'Pro', 'Mon', 'Arm', 'Sup', 'Cart', 'Char',
    'Re', 'Clean', 'Re', 'Trans', 'An', 'Stereo', 'Play', 'Com', 'Amp');

  Middles : array[0..24] of string = (
    'put', 'hold', 'ceiv', 'woof', 'mut', 'top', 'ta', 'le', 'cul', 'cess',
    'tell', 'ject', 'find', 'pick', 'band', 'cord', 'plott', 'tin', 'cycl',
    'tect', 'ni', 'cord', 'lict', 'tin', 'lifi');

  Suffixes : array[0..14] of string = (
    'er', 'or', 'er', 'on', 'phone', 'ra', 'entor', 'ator', 'ar', 'er',
    'scope', 'or', 'ry', 'ridge', 'let');

  OptionalSuffixes : array[0..12] of string = (
    'ic', 'im', 'in', 'up', 'ad', 'er', 'on', 'ep', 'ed',
    'let', 'ga', 'aqu', 'ef');
var
  Prefix, Middle, Suffix, OptionalSuffix : string;
begin
  // Seleccionar un prefijo aleatorio
  Prefix := Prefixes[Random(Length(Prefixes))];

  // Seleccionar una parte intermedia aleatoria
  Middle := Middles[Random(Length(Middles))];

  // Seleccionar un sufijo opcional aleatorio (puede estar vacío)
  if Random(2) = 1 then // 50% de probabilidad de añadir un sufijo opcional
    OptionalSuffix := OptionalSuffixes[Random(Length(OptionalSuffixes))]
  else
    OptionalSuffix := '';

  // Seleccionar un sufijo final aleatorio
  Suffix := Suffixes[Random(Length(Suffixes))];

  // Combinar todas las partes para formar el nombre del producto
  Result := Prefix + Middle + OptionalSuffix + Suffix;
end;

class function TDataGenerator.GenerateRandomProductCategory(Locale : TDataLocale) : string;
const
  Categories_ES : array[0..74] of string = (
    'Accesorios', 'Accesorios Tecnológicos', 'Alimentos Orgánicos',
    'Arte y Manualidades', 'Artículos de Colección', 'Audible', 'Audio y Sonido',
    'Automoción', 'Bebés', 'Bebidas', 'Belleza', 'Bicicletas y Accesorios',
    'Cámaras y Fotografía', 'Camping y Montañismo', 'Computadoras',
    'Cuidado Personal', 'Decoración del Hogar', 'Dispositivos Inteligentes',
    'Educación y Material Escolar', 'Electrodomésticos', 'Electrónica',
    'Equipaje y Maletas', 'Ferretería', 'Fitness y Ejercicio', 'Herramientas',
    'Hogar', 'Instrumentos Musicales', 'Jardín', 'Juegos', 'Joyas',
    'Joyería Artesanal', 'Juguetes', 'Lencería', 'Libros', 'Libros Electrónicos',
    'Materiales de Oficina', 'Muebles', 'Música', 'Moda Sostenible',
    'Películas', 'Patio', 'Perfumes y Fragancias', 'Productos de Limpieza',
    'Ropa', 'Ropa Deportiva', 'Ropa de Invierno', 'Ropa de Verano',
    'Ropa Interior', 'Salud', 'Salud Sexual', 'Seguridad del Hogar',
    'Servicios de Streaming', 'Software y Aplicaciones',
    'Suplementos Nutricionales', 'Tarjetas de Regalo', 'Textiles del Hogar',
    'Utensilios de Cocina', 'Vehículos Eléctricos', 'Videojuegos y Consolas',
    'Vinilos y Discos', 'Vinos y Licores', 'Zapatos', 'Zapatos Casuales',
    'Zapatos Deportivos', 'Zapatos Formales', 'Zapatillas de Casa',
    'Zapatillas de Senderismo', 'Zapatillas para Niños',
    'Accesorios para Mascotas', 'Comida', 'Mascotas', 'Farmacia', 'Aire Libre',
    'Regalos', 'Productos para el Cabello');

  Categories_US : array[0..74] of string = (
    'Accessories', 'Tech Accessories', 'Organic Food', 'Art and Crafts',
    'Collectibles', 'Audible', 'Audio and Sound', 'Automotive', 'Baby',
    'Beverages', 'Beauty', 'Bicycles and Accessories', 'Cameras and Photography',
    'Camping and Hiking', 'Computers', 'Personal Care', 'Home Decor',
    'Smart Devices', 'Education and School Supplies', 'Appliances',
    'Electronics', 'Luggage and Bags', 'Hardware', 'Fitness and Exercise',
    'Tools', 'Home', 'Musical Instruments', 'Garden', 'Games', 'Jewelry',
    'Handcrafted Jewelry', 'Toys', 'Lingerie', 'Books', 'E-books',
    'Office Supplies', 'Furniture', 'Music', 'Sustainable Fashion', 'Movies',
    'Patio', 'Perfumes and Fragrances', 'Cleaning Products', 'Clothing',
    'Sportswear', 'Winter Clothing', 'Summer Clothing', 'Underwear', 'Health',
    'Sexual Health', 'Home Security', 'Streaming Services', 'Software and Apps',
    'Nutritional Supplements', 'Gift Cards', 'Home Textiles', 'Kitchen Utensils',
    'Electric Vehicles', 'Video Games and Consoles', 'Vinyl and Records',
    'Wines and Spirits', 'Shoes', 'Casual Shoes', 'Sports Shoes', 'Formal Shoes',
    'House Slippers', 'Hiking Shoes', 'Kids Shoes', 'Pet Accessories', 'Food',
    'Pets', 'Pharmacy', 'Outdoor', 'Gifts', 'Hair Products');

begin
  case Locale of
    dlLatino : Result := Categories_ES[Random(Length(Categories_ES))];
    dlUS     : Result := Categories_US[Random(Length(Categories_US))];
  end;
end;

class function TDataGenerator.GenerateRandomSizeUnit : string;
const
  SizeUnits : array[0..14] of string = (
    // Unidades de longitud (Length)
    'mm', 'cm', 'm', 'in', 'ft', 'yd', 'mi', 'nm', 'µm', 'dm', 'hm',
    'dam', 'pc', 'AU', 'ly');
begin
  Result := SizeUnits[Random(Length(SizeUnits))];
end;

class function TDataGenerator.GenerateRandomWeightUnit : string;
const
  WeightUnits : array[0..7] of string = ('g', 'kg', 'lb', 'mg', 'oz','t', 'st', 'ct');
begin
  Result := WeightUnits[Random(Length(WeightUnits))];
end;

class function TDataGenerator.GenerateRandomVolumeUnit : string;
const
  VolumeUnits : array[0..9] of string = ('ml', 'cl', 'l', 'dl', 'hl', 'cc',
                                         'gal', 'qt', 'pt', 'fl oz');
begin
  Result := VolumeUnits[Random(Length(VolumeUnits))];
end;

class function TDataGenerator.GenerateRandomColorName(Locale : TDataLocale) : string;
const
  ColorNames_US : array[0..29] of string = (
    'Blue', 'Red', 'Green', 'Black', 'White', 'Yellow', 'Orange', 'Purple',
    'Pink', 'Brown', 'Gray', 'Cyan', 'Magenta', 'Lime', 'Maroon', 'Navy',
    'Olive', 'Teal', 'Silver', 'Gold', 'Beige', 'Indigo', 'Violet', 'Turquoise',
    'Coral', 'Salmon', 'Khaki', 'Lavender', 'Plum', 'Tan');

  ColorNames_ES : array[0..29] of string = (
    'Azul', 'Rojo', 'Verde', 'Negro', 'Blanco', 'Amarillo', 'Naranja', 'Púrpura',
    'Rosa', 'Marrón', 'Gris', 'Cian', 'Magenta', 'Lima', 'Granate', 'Azul marino',
    'Oliva', 'Verde azulado', 'Plata', 'Oro', 'Beige', 'Índigo', 'Violeta',
    'Turquesa', 'Coral', 'Salmón', 'Caqui', 'Lavanda', 'Ciruela', 'Bronceado');
begin
  case Locale of
    dlLatino : Result := ColorNames_ES[Random(Length(ColorNames_ES))];
    dlUS     : Result := ColorNames_US[Random(Length(ColorNames_US))];
  end;

end;

class function TDataGenerator.GenerateRandomClothingSize(TypeSize : TypeOfSize) : string;
const
  LetterSizes : array[0..5] of string = ('S', 'XS', 'M', 'L', 'XL', 'XXL');
  NumberSizes : array[0..10] of string = ('30', '32', '34', '36', '38', '40',
                                          '42', '44', '46', '48', '50');
begin
  // Validar el parámetro y generar la talla correspondiente
  if (TypeSize = Letters) then
    Result := LetterSizes[Random(Length(LetterSizes))]
  else if (TypeSize = Numbers) then
    Result := NumberSizes[Random(Length(NumberSizes))]
  else
    raise Exception.Create('Parámetro no válido. Use "Letters" o "Numbers".');
end;

class function TDataGenerator.GenerateRandomISBN : string;
var
  FormatType : Integer;
  Part1, Part2, Part3, Part4 : string;
  I : Integer;
begin
  // Seleccionar un formato aleatorio para el ISBN
  FormatType := Random(4); // 0, 1, 2 o 3

  case FormatType of
    0 :
      begin
        // Formato: XXXX-X-XXXX-X
        Part1 := '';
        for I := 1 to 4 do
          Part1 := Part1 + IntToStr(Random(10));

        Part2 := IntToStr(Random(10));
        Part3 := '';

        for I := 1 to 4 do
          Part3 := Part3 + IntToStr(Random(10));

        Part4 := IntToStr(Random(10));
        Result := Part1 + '-' + Part2 + '-' + Part3 + '-' + Part4;
      end;
    1 :
      begin
        // Formato: XX-XXX-XXXX-X
        Part1 := '';
        for I := 1 to 2 do
          Part1 := Part1 + IntToStr(Random(10));

        Part2 := '';
        for I := 1 to 3 do
          Part2 := Part2 + IntToStr(Random(10));

        Part3 := '';
        for I := 1 to 4 do
          Part3 := Part3 + IntToStr(Random(10));

        Part4  := IntToStr(Random(10));
        Result := Part1 + '-' + Part2 + '-' + Part3 + '-' + Part4;
      end;
    2 :
      begin
        // Formato: X-XXXXX-XXX-X
        Part1 := IntToStr(Random(10));
        Part2 := '';
        for I := 1 to 5 do
          Part2 := Part2 + IntToStr(Random(10));

        Part3 := '';
        for I := 1 to 3 do
          Part3 := Part3 + IntToStr(Random(10));

        Part4  := IntToStr(Random(10));
        Result := Part1 + '-' + Part2 + '-' + Part3 + '-' + Part4;
      end;
    3 :
      begin
        // Formato: XX-XXXXXX-X-X
        Part1 := '';
        for I := 1 to 2 do
          Part1 := Part1 + IntToStr(Random(10));

        Part2 := '';
        for I := 1 to 6 do
          Part2 := Part2 + IntToStr(Random(10));

        Part3  := IntToStr(Random(10));
        Part4  := IntToStr(Random(10));
        Result := Part1 + '-' + Part2 + '-' + Part3 + '-' + Part4;
      end;
  end;
end;

class function TDataGenerator.GenerateRandomEAN13 : string;
var
  I, Sum, Digit : Integer;
  EAN : string;
begin
  // Generar los primeros 12 dígitos de manera aleatoria
  EAN := '';

  for I := 1 to 12 do
    EAN := EAN + IntToStr(Random(10));

  // Calcular el dígito de control (dígito 13) usando el algoritmo de Luhn
  Sum := 0;

  for I := 1 to 12 do
  begin
    Digit := StrToInt(EAN[I]);

    if I mod 2 = 0 then
      Sum := Sum + Digit
    else
      Sum := Sum + Digit * 3;
  end;

  // Calcular el dígito de control
  Digit := (10 - (Sum mod 10)) mod 10;
  EAN   := EAN + IntToStr(Digit);

  // Formatear el EAN-13 en el formato XXX-X-XXX-XXXXX-X
  Result :=
    EAN[1] + EAN[2] + EAN[3] + '-' +
    EAN[4] + '-' +
    EAN[5] + EAN[6] + EAN[7] + '-' +
    EAN[8] + EAN[9] + EAN[10] + EAN[11] + EAN[12] + '-' +
    EAN[13];
end;

class function TDataGenerator.GenerateRandomTrackingNumber : string;
const
  Letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; // Letras válidas (A-Z)
  Countries : array[0..14] of string = (
    'AU', 'US', 'GB', 'CA', 'DE', 'FR', 'JP', 'CN',
    'IN', 'BR', 'RU', 'IT', 'ES', 'MX', 'KR'); // Códigos de países comunes
var
  Prefix, Suffix : string;
  Number : string;
  I : Integer;
begin
  // Generar dos letras aleatorias para el prefijo
  Prefix := '';
  for I := 1 to 2 do
    Prefix := Prefix + Letters[Random(Length(Letters)) + 1];

  // Generar un número de 9 dígitos
  Number := '';
  for I := 1 to 9 do
    Number := Number + IntToStr(Random(10));

  // Seleccionar un código de país aleatorio
  Suffix := Countries[Random(Length(Countries))];

  // Combinar prefijo, número y sufijo en el formato XX 999999999 YY
  Result := Prefix + ' ' + Number + ' ' + Suffix;
end;

class function TDataGenerator.GenerateRandomShippingMethod : string;
const
  ShippingMethods : array[0..11] of string = (
    'USPS Express Mail', 'USPS Priority Mail', 'USPS First Class Mail',
    'FedEx', 'DHL', 'TNT', 'FedEx Freight', 'Airmail Economy',
    'Airmail Priority', 'Boxberry Courier', 'Boxberry Local Pickup', 'MPS');
begin
  Result := ShippingMethods[Random(Length(ShippingMethods))];
end;

class function TDataGenerator.GenerateRandomPackageType(Locale : TDataLocale) : string;
const
  PackageTypes_EN : array[0..28] of string = (
    'Bag', 'Block', 'Bottle', 'Box', 'Can', 'Carton', 'Each', 'Kg',
    'Packet', 'Pair', 'Pallet', 'Tray', 'Tub', 'Tube', 'Jar', 'Drum',
    'Case', 'Roll', 'Bundle', 'Sack', 'Envelope', 'Container', 'Barrel',
    'Crate', 'Wrap', 'Pouch', 'Blister Pack', 'Shrink Wrap', 'Vacuum Sealed');

  PackageTypes_ES : array[0..28] of string = (
    'Bolsa', 'Bloque', 'Botella', 'Caja', 'Lata', 'Cartón', 'Unidad', 'Kg',
    'Paquete', 'Par', 'Paleta', 'Bandeja', 'Tina', 'Tubo', 'Frasco', 'Tambor',
    'Caja grande', 'Rollo', 'Fardo', 'Saco', 'Sobre', 'Contenedor', 'Barril',
    'Jaulón', 'Envoltura', 'Bolsita', 'Blíster', 'Encogible', 'Al vacío');

begin
  case Locale of
    dlLatino : Result := PackageTypes_ES[Random(Length(PackageTypes_ES))];
    dlUS     : Result := PackageTypes_EN[Random(Length(PackageTypes_EN))];
  end;

end;

class function TDataGenerator.GenerateRandomFruit(Locale : TDataLocale) : string;
const
  FRUTAS_ES : array[0..49] of string = (
    'Manzana', 'Plátano', 'Naranja', 'Uva', 'Fresa',
    'Mango', 'Piña', 'Sandía', 'Melón', 'Kiwi',
    'Pera', 'Cereza', 'Limón', 'Lima', 'Toronja',
    'Zanahoria', 'Arándano', 'Zarzamora', 'Frambuesa', 'Granada',
    'Papaya', 'Maracuyá', 'Guayaba', 'Coco', 'Higo',
    'Durazno', 'Ciruela', 'Mora', 'Lichi', 'Aguacate',
    'Mandarina', 'Pomelo', 'Kiwano', 'Caqui', 'Chirimoya',
    'Membrillo', 'Grosella', 'Níspero', 'Carambola', 'Tamarindo',
    'Higo Chumbo', 'Pitahaya', 'Rambután', 'Longan', 'Mangostán',
    'Uchuva', 'Pepino', 'Tomate', 'Albaricoque', 'Cantalupo');

  FRUTAS_EN : array[0..49] of string = (
    'Apple', 'Banana', 'Orange', 'Grape', 'Strawberry',
    'Mango', 'Pineapple', 'Watermelon', 'Melon', 'Kiwi',
    'Pear', 'Cherry', 'Lemon', 'Lime', 'Grapefruit',
    'Carrot', 'Blueberry', 'Blackberry', 'Raspberry', 'Pomegranate',
    'Papaya', 'Passion Fruit', 'Guava', 'Coconut', 'Fig',
    'Peach', 'Plum', 'Mulberry', 'Lychee', 'Avocado',
    'Tangerine', 'Pomelo', 'Horned Melon', 'Persimmon', 'Cherimoya',
    'Quince', 'Currant', 'Loquat', 'Starfruit', 'Tamarind',
    'Prickly Pear', 'Dragon Fruit', 'Rambutan', 'Longan', 'Mangosteen',
    'Cape Gooseberry', 'Cucumber', 'Tomato', 'Apricot', 'Cantaloupe');

begin
  case Locale of
    dlLatino : Result := FRUTAS_ES[Random(Length(FRUTAS_ES))];
    dlUS     : Result := FRUTAS_EN[Random(Length(FRUTAS_EN))];
  end;

end;

class function TDataGenerator.GenerateRandomDrink(Locale : TDataLocale) : string;
const
  BEBIDAS_ES : array[0..49] of string = (
    'Agua Mineral', 'Refresco de Cola', 'Jugo de Naranja', 'Café', 'Té Negro',
    'Limonada', 'Cerveza', 'Vino Tinto', 'Vino Blanco', 'Champán',
    'Batido de Fresa', 'Leche', 'Chocolate Caliente', 'Refresco de Limón',
    'Energética', 'Té Verde', 'Infusión de Manzanilla', 'Mojito', 'Piña Colada',
    'Margarita', 'Whisky', 'Ron', 'Ginebra', 'Vodka', 'Sangría', 'Agua con Gas',
    'Jugo de Manzana', 'Jugo de Uva', 'Jugo de Piña', 'Jugo de Zanahoria',
    'Smoothie de Mango', 'Smoothie de Plátano', 'Batido de Chocolate',
    'Batido de Vainilla', 'Batido de Frutas Mixtas', 'Café Latte', 'Cappuccino',
    'Espresso', 'Té de Hierbas', 'Té de Frutas', 'Sidra', 'Coctel de Frutas',
    'Malta', 'Refresco de Naranja', 'Refresco de Uva', 'Refresco de Toronja',
    'Refresco de Frambuesa', 'Refresco de Piña', 'Refresco de Melón',
    'Agua de Coco');

  BEBIDAS_EN : array[0..49] of string = (
    'Mineral Water', 'Cola Soda', 'Orange Juice', 'Coffee', 'Black Tea',
    'Lemonade', 'Beer', 'Red Wine', 'White Wine', 'Champagne',
    'Strawberry Smoothie', 'Milk', 'Hot Chocolate', 'Lemon Soda',
    'Energy Drink', 'Green Tea', 'Chamomile Infusion', 'Mojito', 'Piña Colada',
    'Margarita', 'Whisky', 'Rum', 'Gin', 'Vodka', 'Sangria',
    'Sparkling Water', 'Apple Juice', 'Grape Juice', 'Pineapple Juice',
    'Carrot Juice', 'Mango Smoothie', 'Banana Smoothie', 'Chocolate Milkshake',
    'Vanilla Milkshake', 'Mixed Fruit Smoothie', 'Latte', 'Cappuccino',
    'Espresso', 'Herbal Tea', 'Fruit Tea', 'Cider', 'Fruit Cocktail',
    'Malt Beverage', 'Orange Soda', 'Grape Soda', 'Grapefruit Soda',
    'Raspberry Soda', 'Pineapple Soda', 'Melon Soda', 'Coconut Water');

begin
  case Locale of
    dlLatino : Result := BEBIDAS_ES[Random(Length(BEBIDAS_ES))];
    dlUS     : Result := BEBIDAS_EN[Random(Length(BEBIDAS_EN))];
  end;

end;

class function TDataGenerator.GenerateRandomDish(Locale : TDataLocale) : string;
const
  PLATOS_ES : array[0..52] of string = (
    'Pizza Margarita', 'Hamburguesa con Queso', 'Espaguetis a la Boloñesa',
    'Pollo Asado', 'Sushi', 'Tacos al Pastor', 'Ensalada César',
    'Pasta Alfredo', 'Paella Valenciana', 'Chiles Rellenos', 'Filete Mignon',
    'Ceviche', 'Ramen', 'Costillas BBQ', 'Lasaña', 'Sopa de Tomate',
    'Tarta de Manzana', 'Pescado Frito', 'Burritos', 'Nachos', 'Curry de Pollo',
    'Empanadas Argentinas', 'Falafel', 'Pad Thai', 'Guiso de Lentejas',
    'Quesadillas', 'Arroz con Pollo', 'Bistec a la Parrilla', 'Sándwich Club',
    'Papas Bravas', 'Cordero Asado', 'Caldo de Pollo', 'Poutine', 'Tiramisú',
    'Hot Dog', 'Alitas de Pollo', 'Salteñas Bolivianas', 'Fajitas', 'Pupusas',
    'Churrasco', 'Sopa de Mariscos', 'Croissant', 'Baguette con Jamón y Queso',
    'Ravioli', 'Moussaka', 'Pancakes', 'Waffles', 'Crema de Espárragos',
    'Pastel de Carne', 'Brochetas de Res', 'Flan de Caramelo', 'Cheesecake',
    'Panqueques de Plátano');

  PLATOS_EN : array[0..52] of string = (
    'Margherita Pizza', 'Cheeseburger', 'Spaghetti Bolognese', 'Roast Chicken',
    'Sushi', 'Tacos al Pastor', 'Caesar Salad', 'Fettuccine Alfredo', 'Paella',
    'Stuffed Peppers', 'Filet Mignon', 'Ceviche', 'Ramen', 'BBQ Ribs', 'Lasagna',
    'Tomato Soup', 'Apple Pie', 'Fried Fish', 'Burritos', 'Nachos',
    'Chicken Curry', 'Argentinian Empanadas', 'Falafel', 'Pad Thai',
    'Lentil Stew', 'Quesadillas', 'Chicken and Rice', 'Grilled Steak',
    'Club Sandwich', 'Patatas Bravas', 'Roast Lamb', 'Chicken Broth', 'Poutine',
    'Tiramisu', 'Hot Dog', 'Chicken Wings', 'Bolivian Salteñas', 'Fajitas',
    'Pupusas', 'Churrasco', 'Seafood Soup', 'Croissant',
    'Ham and Cheese Baguette', 'Ravioli', 'Moussaka', 'Pancakes', 'Waffles',
    'Cream of Asparagus', 'Meatloaf', 'Beef Skewers', 'Caramel Flan',
    'Cheesecake', 'Banana Pancakes');

begin
  case Locale of
    dlLatino : Result := PLATOS_ES[Random(Length(PLATOS_ES))];
    dlUS     : Result := PLATOS_EN[Random(Length(PLATOS_EN))];
  end;

end;

class function TDataGenerator.GenerateRandomSupermarket(Locale : TDataLocale) : string;
const
  PRODUCTOS_SUPERMERCADO_ES : array[0..49] of string = (
    'Arroz', 'Frijoles', 'Pasta', 'Aceite de Oliva', 'Azúcar',
    'Sal', 'Harina', 'Leche', 'Huevos', 'Pan',
    'Atún enlatado', 'Sopa enlatada', 'Cereal', 'Galletas', 'Yogur',
    'Queso', 'Mantequilla', 'Jamón', 'Pollo fresco', 'Carne de res',
    'Papel higiénico', 'Detergente', 'Jabón', 'Shampoo', 'Café',
    'Té', 'Refresco', 'Agua embotellada', 'Jugo de naranja', 'Mayonesa',
    'Kétchup', 'Mostaza', 'Vinagre', 'Salsa de soja', 'Cacahuates',
    'Papas fritas', 'Chocolate', 'Helado', 'Cerveza', 'Vino',
    'Pasta dental', 'Cepillo de dientes', 'Pañales', 'Cerveza sin alcohol',
    'Gelatina', 'Conservas de frutas', 'Miel', 'Avena', 'Granola',
    'Aderezo para ensaladas');

  PRODUCTOS_SUPERMERCADO_EN : array[0..49] of string = (
    'Rice', 'Beans', 'Pasta', 'Olive Oil', 'Sugar',
    'Salt', 'Flour', 'Milk', 'Eggs', 'Bread',
    'Canned Tuna', 'Canned Soup', 'Cereal', 'Cookies', 'Yogurt',
    'Cheese', 'Butter', 'Ham', 'Fresh Chicken', 'Beef',
    'Toilet Paper', 'Detergent', 'Soap', 'Shampoo', 'Coffee',
    'Tea', 'Soda', 'Bottled Water', 'Orange Juice', 'Mayonnaise',
    'Ketchup', 'Mustard', 'Vinegar', 'Soy Sauce', 'Peanuts',
    'Potato Chips', 'Chocolate', 'Ice Cream', 'Beer', 'Wine',
    'Toothpaste', 'Toothbrush', 'Diapers', 'Non-Alcoholic Beer', 'Gelatin',
    'Canned Fruits', 'Honey', 'Oats', 'Granola', 'Salad Dressing');

begin
  case Locale of
    dlLatino : Result := PRODUCTOS_SUPERMERCADO_ES[Random(Length(PRODUCTOS_SUPERMERCADO_ES))];
    dlUS     : Result := PRODUCTOS_SUPERMERCADO_EN[Random(Length(PRODUCTOS_SUPERMERCADO_EN))];
  end;

end;

class function TDataGenerator.GenerateRandomHardware(Locale : TDataLocale) : string;
const
  PRODUCTOS_FERRETERIA_ES : array[0..54] of string = (
    'Martillo', 'Destornillador', 'Llave inglesa', 'Pinzas', 'Taladro',
    'Clavos', 'Tornillos', 'Tuercas', 'Pegamento industrial', 'Cinta métrica',
    'Sierra', 'Brocas', 'Alicate', 'Escalera', 'Candado',
    'Cerradura', 'Bisagras', 'Cables eléctricos', 'Interruptores',
    'Tomacorrientes', 'Tubería PVC', 'Codos PVC', 'Sellador silicona',
    'Pintura látex', 'Rodillo de pintura', 'Brocha', 'Cinta aislante',
    'Linterna', 'Baterías', 'Bombillas', 'Extensión eléctrica',
    'Guantes de trabajo', 'Casco de seguridad', 'Gafas protectoras', 'Mascarilla',
    'Cuerda', 'Cadena', 'Caja de herramientas', 'Esmeril', 'Lija',
    'Adhesivo epóxico', 'Cemento', 'Cal', 'Arena', 'Varilla de construcción',
    'Alambre', 'Clavo de acero', 'Perno expansor', 'Silicona líquida',
    'Malla metálica', 'Cortadora de cerámica', 'Nivel de burbuja',
    'Desarmador eléctrico', 'Compresor de aire', 'Pala');

  PRODUCTOS_FERRETERIA_EN : array[0..54] of string = (
    'Hammer', 'Screwdriver', 'Wrench', 'Pliers', 'Drill',
    'Nails', 'Screws', 'Nuts', 'Industrial Glue', 'Measuring Tape',
    'Saw', 'Drill Bits', 'Pliers', 'Ladder', 'Lock',
    'Door Lock', 'Hinges', 'Electric Cables', 'Switches', 'Outlets',
    'PVC Pipe', 'PVC Elbows', 'Silicone Sealant', 'Latex Paint', 'Paint Roller',
    'Paintbrush', 'Electrical Tape', 'Flashlight', 'Batteries', 'Light Bulbs',
    'Extension Cord', 'Work Gloves', 'Safety Helmet', 'Protective Glasses',
    'Mask', 'Rope', 'Chain', 'Toolbox', 'Grinder', 'Sandpaper',
    'Epoxy Adhesive', 'Cement', 'Lime', 'Sand', 'Rebar', 'Wire', 'Steel Nail',
    'Expansion Bolt', 'Liquid Silicone', 'Metal Mesh', 'Ceramic Cutter',
    'Bubble Level', 'Electric Screwdriver', 'Air Compressor', 'Shovel');

begin
  case Locale of
    dlLatino : Result := PRODUCTOS_FERRETERIA_ES[Random(Length(PRODUCTOS_FERRETERIA_ES))];
    dlUS     : Result := PRODUCTOS_FERRETERIA_EN[Random(Length(PRODUCTOS_FERRETERIA_EN))];
  end;

end;

class function TDataGenerator.GenerateRandomStoreItems(Locale : TDataLocale) : string;
const
  ARTICULOS_TIENDA_ES : array[0..49] of string = (
    'Camiseta básica', 'Jeans', 'Zapatos deportivos', 'Reloj de pulsera',
    'Bolso de mano', 'Gorra', 'Bufanda', 'Cinturón', 'Vestido casual',
    'Chaqueta de cuero', 'Paraguas', 'Gafas de sol', 'Pijama', 'Calcetines',
    'Ropa interior', 'Zapatillas de casa', 'Sandalias', 'Botas', 'Suéter', 'Blusa',
    'Libro bestseller', 'Cuaderno', 'Lápices de colores', 'Agenda', 'Mochila escolar',
    'Taza personalizada', 'Llavero', 'Perfume', 'Set de maquillaje',
    'Joyería de fantasía', 'Collar', 'Pulsera', 'Anillo', 'Pendientes',
    'Corbata', 'Sombrero', 'Guantes de invierno', 'Chaleco', 'Shorts',
    'Leggings', 'Ropa de bebé', 'Juguetes educativos',
    'Tarjetas de felicitación', 'Marcadores', 'Estuche escolar',
    'Pañuelos desechables', 'Cartera', 'Cadena para el cuello',
    'Broche decorativo', 'Caja de regalo');

  ARTICULOS_TIENDA_EN : array[0..49] of string = (
    'Basic T-Shirt', 'Jeans', 'Sneakers', 'Wristwatch', 'Handbag',
    'Cap', 'Scarf', 'Belt', 'Casual Dress', 'Leather Jacket',
    'Umbrella', 'Sunglasses', 'Pajamas', 'Socks', 'Underwear',
    'House Slippers', 'Sandals', 'Boots', 'Sweater', 'Blouse',
    'Bestseller Book', 'Notebook', 'Color Pencils', 'Planner', 'School Backpack',
    'Custom Mug', 'Keychain', 'Perfume', 'Makeup Set', 'Fashion Jewelry',
    'Necklace', 'Bracelet', 'Ring', 'Earrings', 'Tie', 'Hat', 'Winter Gloves',
    'Vest', 'Shorts', 'Leggings', 'Baby Clothes', 'Educational Toys',
    'Greeting Cards', 'Markers', 'Pencil Case', 'Disposable Handkerchiefs',
    'Wallet', 'Necklace Chain', 'Decorative Brooch', 'Gift Box');

begin
  case Locale of
    dlLatino : Result := ARTICULOS_TIENDA_ES[Random(Length(ARTICULOS_TIENDA_ES))];
    dlUS     : Result := ARTICULOS_TIENDA_EN[Random(Length(ARTICULOS_TIENDA_EN))];
  end;

end;

class function TDataGenerator.GenerateRandomSportItems(Locale : TDataLocale) : string;
const
  ARTICULOS_DEPORTIVOS_ES : array[0..54] of string = (
    'Balón de fútbol', 'Zapatillas deportivas', 'Guantes de portero',
    'Ropa deportiva', 'Casco de ciclismo', 'Raqueta de tenis',
    'Pelota de baloncesto', 'Gorra deportiva', 'Mochila deportiva',
    'Bolsa de gimnasio', 'Rodilleras', 'Codoletas', 'Muñequeras',
    'Bandas elásticas', 'Pesas ajustables', 'Colchoneta de yoga',
    'Bicicleta estática', 'Cuerda para saltar', 'Botella deportiva',
    'Reloj deportivo', 'Proteínas en polvo', 'Suplementos energéticos',
    'Barra de tracción', 'Esterilla de ejercicio', 'Mancuernas',
    'Bate de béisbol', 'Pelota de voleibol', 'Red de voleibol', 'Palo de golf',
    'Pelotas de golf', 'Patines en línea', 'Monopatín', 'Tabla de surf',
    'Kayak', 'Chaleco salvavidas', 'Linterna frontal', 'Brújula',
    'Mapa topográfico', 'Tienda de campaña', 'Saco de dormir',
    'Bastones de trekking', 'Botas de montaña', 'Gafas de natación',
    'Traje de neopreno', 'Aletas', 'Pelota de rugby', 'Casco de esquí',
    'Esquís', 'Snowboard', 'Paracaídas deportivo', 'Equipo de buceo',
    'Rueda de ejercicios', 'Banda de resistencia', 'Guantes de levantamiento',
    'Calcetines deportivos');

  ARTICULOS_DEPORTIVOS_EN : array[0..54] of string = (
    'Soccer Ball', 'Sports Shoes', 'Goalkeeper Gloves', 'Sportswear',
    'Cycling Helmet', 'Tennis Racket', 'Basketball', 'Sports Cap',
    'Sports Backpack', 'Gym Bag', 'Knee Pads', 'Elbow Pads', 'Wristbands',
    'Resistance Bands', 'Adjustable Weights', 'Yoga Mat', 'Stationary Bike',
    'Jump Rope', 'Sports Bottle', 'Sports Watch', 'Protein Powder',
    'Energy Supplements', 'Pull-Up Bar', 'Exercise Mat', 'Dumbbells',
    'Baseball Bat', 'Volleyball', 'Volleyball Net', 'Golf Club', 'Golf Balls',
    'Inline Skates', 'Skateboard', 'Surfboard', 'Kayak', 'Life Jacket',
    'Headlamp', 'Compass', 'Topographic Map', 'Tent', 'Sleeping Bag',
    'Trekking Poles', 'Hiking Boots', 'Swimming Goggles', 'Wetsuit', 'Fins',
    'Rugby Ball', 'Ski Helmet', 'Skis', 'Snowboard', 'Parachute', 'Diving Gear',
    'Exercise Wheel', 'Resistance Band', 'Weightlifting Gloves', 'Sports Socks');

begin
  case Locale of
    dlLatino : Result := ARTICULOS_DEPORTIVOS_ES[Random(Length(ARTICULOS_DEPORTIVOS_ES))];
    dlUS     : Result := ARTICULOS_DEPORTIVOS_EN[Random(Length(ARTICULOS_DEPORTIVOS_EN))];
  end;

end;

class function TDataGenerator.GenerateRandomFurnitureItems(Locale : TDataLocale) : string;
const
  ARTICULOS_MUEBLES_ES : array[0..53] of string = (
    'Sofá', 'Mesa de comedor', 'Silla de comedor', 'Cama matrimonial', 'Colchón',
    'Ropero', 'Escritorio', 'Silla de oficina', 'Mesa de centro', 'Estantería',
    'Armario modular', 'Cómoda', 'Cabecera tapizada', 'Mesa de noche',
    'Banco de entrada', 'Librero', 'Sillón reclinable', 'Mesa de café',
    'Mesa plegable', 'Silla plegable', 'Estante flotante', 'Perchero de pared',
    'Espejo de cuerpo entero', 'Cortinas', 'Alfombra', 'Lámpara de pie',
    'Lámpara de mesa', 'Candelabro', 'Reloj de pared', 'Cuadro decorativo',
    'Jarrón decorativo', 'Maceta grande', 'Cojines decorativos', 'Manta de sofá',
    'Portarretratos', 'Organizador de zapatos', 'Caja de almacenamiento',
    'Repisa para TV', 'Barra de cortina', 'Cajonera', 'Mesa auxiliar',
    'Taburete alto', 'Mesa de planchar', 'Tocador con espejo', 'Banqueta tapizada',
    'Cuna para bebé', 'Cambiador de pañales', 'Mesa de juegos infantil',
    'Silla infantil', 'Cama nido', 'Set de cubiertos decorativos',
    'Juego de tazas', 'Centro de entretenimiento', 'Mueble bar');

  ARTICULOS_MUEBLES_EN : array[0..53] of string = (
    'Sofa', 'Dining Table', 'Dining Chair', 'Queen Bed', 'Mattress',
    'Wardrobe', 'Desk', 'Office Chair', 'Coffee Table', 'Bookshelf',
    'Modular Closet', 'Dresser', 'Upholstered Headboard', 'Nightstand',
    'Entry Bench', 'Bookcase', 'Recliner', 'Coffee Table', 'Folding Table',
    'Folding Chair', 'Floating Shelf', 'Wall Hanger', 'Full-Length Mirror',
    'Curtains', 'Rug', 'Floor Lamp', 'Table Lamp', 'Chandelier', 'Wall Clock',
    'Decorative Painting', 'Decorative Vase', 'Large Planter',
    'Decorative Pillows', 'Throw Blanket', 'Picture Frame', 'Shoe Organizer',
    'Storage Box', 'TV Stand', 'Curtain Rod', 'Chest of Drawers', 'Side Table',
    'Bar Stool', 'Ironing Board', 'Dresser with Mirror', 'Upholstered Stool',
    'Baby Crib', 'Diaper Changer', 'Kids Play Table', 'Kids Chair', 'Bunk Bed',
    'Decorative Cutlery Set', 'Cup Set', 'Entertainment Center', 'Bar Furniture');

begin
  case Locale of
    dlLatino : Result := ARTICULOS_MUEBLES_ES[Random(Length(ARTICULOS_MUEBLES_ES))];
    dlUS     : Result := ARTICULOS_MUEBLES_EN[Random(Length(ARTICULOS_MUEBLES_EN))];
  end;

end;

class function TDataGenerator.GenerateRandomToy(Locale : TDataLocale) : string;
const
  JUGUETES_ES : array[0..54] of string = (
    'Peluche', 'Muñeca Barbie', 'Carrito Hot Wheels', 'Lego', 'Rompecabezas',
    'Juego de mesa Monopoly', 'Ajedrez', 'Pista de carreras',
    'Robot programable', 'Dron para niños', 'Casita de muñecas',
    'Set de cocina de juguete', 'Bloques de construcción', 'Patines',
    'Monopatín', 'Bicicleta infantil', 'Pelota de fútbol',
    'Set de herramientas de juguete', 'Tren eléctrico', 'Figuras de acción',
    'Videojuego portátil', 'Consola de videojuegos', 'Juego de cartas UNO',
    'Dominó', 'Yo-yo', 'Set de pintura', 'Pistola de agua', 'Set de doctor',
    'Disfraz de superhéroe', 'Muñeco de peluche interactivo', 'Cubo mágico',
    'Set de química', 'Telescopio infantil', 'Microscopio educativo',
    'Set de arte', 'Juego de memoria', 'Pelota saltarina', 'Cometa',
    'Set de dinosaurios', 'Pista de obstáculos', 'Set de magia',
    'Instrumento musical de juguete', 'Juego de dardos magnéticos',
    'Set de pesca magnética', 'Laberinto de canicas',
    'Set de construcción magnético', 'Juego de bolos', 'Set de piratas',
    'Set de granja', 'Set de bomberos', 'Set de princesas',
    'Juego de miniaturas', 'Set de trenes de madera',
    'Juego de roles de veterinario', 'Set de explorador');

  JUGUETES_EN : array[0..54] of string = (
    'Stuffed Animal', 'Barbie Doll', 'Hot Wheels Car', 'LEGO', 'Puzzle',
    'Monopoly Board Game', 'Chess', 'Race Track', 'Programmable Robot',
    'Kids Drone', 'Dollhouse', 'Toy Kitchen Set', 'Building Blocks', 'Skates',
    'Skateboard', 'Kids Bicycle', 'Soccer Ball', 'Toy Tool Set', 'Electric Train',
    'Action Figures', 'Portable Video Game', 'Video Game Console',
    'UNO Card Game', 'Dominoes', 'Yo-Yo', 'Paint Set', 'Water Gun',
    'Doctor Playset', 'Superhero Costume', 'Interactive Stuffed Toy',
    'Rubik’s Cube', 'Chemistry Set', 'Kids Telescope', 'Educational Microscope',
    'Art Set', 'Memory Game', 'Bouncing Ball', 'Kite', 'Dinosaur Set',
    'Obstacle Course', 'Magic Set', 'Toy Musical Instrument',
    'Magnetic Dart Game', 'Magnetic Fishing Set', 'Marble Maze',
    'Magnetic Construction Set', 'Bowling Game', 'Pirate Set', 'Farm Set',
    'Firefighter Set', 'Princess Set', 'Miniature Game', 'Wooden Train Set',
    'Veterinarian Role-Playing Game', 'Explorer Set');

begin
  case Locale of
    dlLatino : Result := JUGUETES_ES[Random(Length(JUGUETES_ES))];
    dlUS     : Result := JUGUETES_EN[Random(Length(JUGUETES_EN))];
  end;

end;

class function TDataGenerator.GenerateRandomBeautySalonServices(Locale : TDataLocale) : string;
const
  SERVICIOS_SALON_ES : array[0..49] of string = (
    'Corte de cabello', 'Manicure', 'Pedicure', 'Tinte para cabello',
    'Tratamiento capilar', 'Lavado y peinado', 'Depilación con cera',
    'Masaje relajante', 'Facial hidratante', 'Exfoliación corporal',
    'Maquillaje profesional', 'Extensiones de pestañas', 'Cejas microblading',
    'Peeling facial', 'Mascarilla capilar', 'Permanente de pestañas',
    'Alisado brasileño', 'Keratina capilar', 'Tratamiento antiacné',
    'Limpieza facial', 'Aromaterapia', 'Reflexología', 'Baño de vapor',
    'Envoltura corporal', 'Drenaje linfático', 'Uñas acrílicas',
    'Esmaltado semipermanente', 'Decoración de uñas', 'Lifting de pestañas',
    'Desintoxicación facial', 'Protector solar facial', 'Crema antiarrugas',
    'Serum facial', 'Aceite para cutículas', 'Champú especializado',
    'Acondicionador hidratante', 'Máscara exfoliante', 'Tonificador facial',
    'Crema corporal hidratante', 'Jabón artesanal', 'Velas aromáticas',
    'Sales de baño', 'Esponjas exfoliantes', 'Brochas de maquillaje',
    'Paleta de sombras', 'Labial mate', 'Rubor compacto', 'Base líquida',
    'Rímel voluminizador', 'Delineador líquido');

  SERVICIOS_SALON_EN : array[0..49] of string = (
    'Haircut', 'Manicure', 'Pedicure', 'Hair Dye', 'Hair Treatment',
    'Wash and Blow Dry', 'Waxing', 'Relaxing Massage', 'Hydrating Facial',
    'Body Scrub', 'Professional Makeup', 'Eyelash Extensions',
    'Eyebrow Microblading', 'Facial Peel', 'Hair Mask', 'Eyelash Perm',
    'Brazilian Straightening', 'Keratin Treatment', 'Acne Treatment',
    'Facial Cleansing', 'Aromatherapy', 'Reflexology', 'Steam Bath', 'Body Wrap',
    'Lymphatic Drainage', 'Acrylic Nails', 'Semi-Permanent Nail Polish',
    'Nail Art', 'Eyelash Lift', 'Facial Detox', 'Facial Sunscreen',
    'Anti-Wrinkle Cream', 'Facial Serum', 'Cuticle Oil', 'Specialized Shampoo',
    'Moisturizing Conditioner', 'Exfoliating Mask', 'Facial Toner',
    'Moisturizing Body Cream', 'Artisan Soap', 'Aromatic Candles', 'Bath Salts',
    'Exfoliating Sponges', 'Makeup Brushes', 'Eyeshadow Palette',
    'Matte Lipstick', 'Compact Blush', 'Liquid Foundation',
    'Volumizing Mascara', 'Liquid Eyeliner');

begin
  case Locale of
    dlLatino : Result := SERVICIOS_SALON_ES[Random(Length(SERVICIOS_SALON_ES))];
    dlUS     : Result := SERVICIOS_SALON_EN[Random(Length(SERVICIOS_SALON_EN))];
  end;

end;



end.
