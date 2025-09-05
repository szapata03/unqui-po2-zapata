!classDefinition: #ScriptsPrueba category: 'TP-02'!
TestCase subclass: #ScriptsPrueba
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TP-02'!

!ScriptsPrueba methodsFor: 'as yet unclassified' stamp: 'SIZ 9/5/2025 17:26:59'!
test001_EmpleadoPermanenteCalculaSueldoBruto

| empleadoPermanente |

empleadoPermanente := EmpleadoPermanente crearEmpleadoConNacimiento: (Date newDay: 1 month: 1 year: 1980)
    nombre: 'Juan Perez'
    direccion: 'Calle Falsa 123'
    estadoCivil: 'Casado'
    sueldoBasico: 10000
    cantidadHijos: 2
    antiguedad: 5.

Assert that: empleadoPermanente calcularSueldoBruto isEqualTo: (10000 + (2 * 150) + 100 + (5 * 50)).

Assert that: empleadoPermanente calcularRetenciones isEqualTo:  (((empleadoPermanente calcularSueldoBruto) * 0.10) + (2 * 20) + ((empleadoPermanente calcularSueldoBruto) * 0.15)).

Assert that: empleadoPermanente calcularSueldoNeto isEqualTo:  (empleadoPermanente calcularSueldoBruto) - (empleadoPermanente calcularRetenciones).
! !

!ScriptsPrueba methodsFor: 'as yet unclassified' stamp: 'SIZ 9/5/2025 18:06:12'!
test002_EmpleadoTemporarioCalculaSueldoBruto

    | empleadoTemporario  |

    empleadoTemporario := EmpleadoTemporario crearEmpleadoConNacimiento: (Date year: 1960 month: 3 day: 25)
        nombre: 'Ana Gomez'
        direccion: 'Av. Siempre Viva 742'
        estadoCivil: 'Soltero'
        sueldoBasico: 8000
        fechaFin: (Date newDay: 31 month: 12 year: 2025)
        horasExtras: 10.


    Assert that: empleadoTemporario calcularSueldoBruto isEqualTo: (8000 + (10 * 40)).
    Assert that: empleadoTemporario calcularRetenciones isEqualTo: ((empleadoTemporario calcularSueldoBruto * 0.10) + ((empleadoTemporario calcularEdad > 50) ifTrue: [25] ifFalse: [0])) + ((empleadoTemporario calcularSueldoBruto * 0.10) + (10 * 5)).
    Assert that: empleadoTemporario calcularSueldoNeto isEqualTo: (empleadoTemporario calcularSueldoBruto - empleadoTemporario calcularRetenciones).
! !

!ScriptsPrueba methodsFor: 'as yet unclassified' stamp: 'SIZ 9/5/2025 18:08:17'!
test003_EmpleadoContratadoCalculaSueldoBruto
    | empleadoContratado |

    empleadoContratado := EmpleadoContratado crearEmpleadoConNacimiento: (Date newDay: 15 month: 3 year: 1990)
        nombre: 'Carlos Diaz'
        direccion: 'Calle Luna 45'
        estadoCivil: 'Casado'
        sueldoBasico: 7000
        numeroContrato: 'C12345'
        medioPago: 'Cheque'.

    Assert that: empleadoContratado calcularSueldoBruto isEqualTo: 7000.
    Assert that: empleadoContratado calcularRetenciones isEqualTo: 50.
    Assert that: empleadoContratado calcularSueldoNeto isEqualTo: (7000 - 50).
! !

!ScriptsPrueba methodsFor: 'as yet unclassified' stamp: 'SIZ 9/5/2025 18:09:55'!
test004_EmpresaCalculaTotalesYLiquidaSueldos
    | empresa |

    empresa := Empresa new.
    empresa agregarEmpleado: (EmpleadoPermanente crearEmpleadoConNacimiento: (Date newDay: 1 month: 1 year: 1980)
        nombre: 'Juan Perez'
        direccion: 'Calle Falsa 123'
        estadoCivil: 'Casado'
        sueldoBasico: 10000
        cantidadHijos: 2
        antiguedad: 5).
    empresa agregarEmpleado: (EmpleadoTemporario crearEmpleadoConNacimiento: (Date newDay: 1 month: 1 year: 1960)
        nombre: 'Ana Gomez'
        direccion: 'Av. Siempre Viva 742'
        estadoCivil: 'Soltero'
        sueldoBasico: 8000
        fechaFin: (Date newDay: 31 month: 12 year: 2025)
        horasExtras: 10).
    empresa agregarEmpleado: (EmpleadoContratado crearEmpleadoConNacimiento: (Date newDay: 15 month: 3 year: 1990)
        nombre: 'Carlos Diaz'
        direccion: 'Calle Luna 45'
        estadoCivil: 'Casado'
        sueldoBasico: 7000
        numeroContrato: 'C12345'
        medioPago: 'Cheque').

    Assert that: empresa totalSueldosNetos isEqualTo: (empresa empleados sum: [:e | e calcularSueldoNeto]).
    Assert that: empresa totalSueldosBrutos isEqualTo: (empresa empleados sum: [:e | e calcularSueldoBruto]).
    Assert that: empresa totalRetenciones isEqualTo: (empresa empleados sum: [:e | e calcularRetenciones]).

    empresa liquidarSueldos.
    Assert that: empresa recibos size isEqualTo: 3.
    Assert that: (empresa recibos first nombre) isEqualTo: 'Juan Perez'.
! !


!classDefinition: #Empleado category: 'TP-02'!
Object subclass: #Empleado
	instanceVariableNames: 'nombre direccion estadoCivil fechaNacimiento sueldoBasico'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TP-02'!

!Empleado methodsFor: 'initialization'!
initializeConNacimiento: unaFecha nombre: unNombre direccion: unaDireccion estadoCivil: unEstadoCivil sueldoBasico: unSueldo
	nombre := unNombre.
	direccion := unaDireccion.
	estadoCivil := unEstadoCivil.
	fechaNacimiento := unaFecha.
	sueldoBasico := unSueldo. 
! !


!Empleado methodsFor: 'calculos' stamp: 'SIZ 9/5/2025 18:07:04'!
calcularEdad
	^ Date today yearNumber - (fechaNacimiento yearNumber). 
! !

!Empleado methodsFor: 'calculos'!
calcularRetenciones
	self subclassResponsibility. 
! !

!Empleado methodsFor: 'calculos'!
calcularSueldoBruto
	self subclassResponsibility. 
! !

!Empleado methodsFor: 'calculos'!
calcularSueldoNeto
	^ self calcularSueldoBruto - self calcularRetenciones. 
! !


!Empleado methodsFor: 'recibos'!
generarRecibo
	| recibo |
	recibo := ReciboDeHaberes new.
	recibo generarPara: self.
	^ recibo. 
! !


!Empleado methodsFor: 'accessing'!
direccion
	^ direccion. 
! !

!Empleado methodsFor: 'accessing'!
nombre
	^ nombre. 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Empleado class' category: 'TP-02'!
Empleado class
	instanceVariableNames: ''!

!Empleado class methodsFor: 'instance creation'!
crearEmpleadoConNacimiento: unaFecha nombre: unNombre direccion: unaDireccion estadoCivil: unEstadoCivil sueldoBasico: unSueldo
	^ self new initializeConNacimiento: unaFecha nombre: unNombre direccion: unaDireccion estadoCivil: unEstadoCivil sueldoBasico: unSueldo; yourself. 
! !


!classDefinition: #EmpleadoContratado category: 'TP-02'!
Empleado subclass: #EmpleadoContratado
	instanceVariableNames: 'numeroContrato medioPago'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TP-02'!

!EmpleadoContratado methodsFor: 'initialization'!
initializeConNacimiento: unaFecha nombre: unNombre direccion: unaDireccion estadoCivil: unEstadoCivil sueldoBasico: unSueldo numeroContrato: contrato medioPago: medio
	nombre := unNombre.
	direccion := unaDireccion.
	estadoCivil := unEstadoCivil.
	fechaNacimiento := unaFecha.
	sueldoBasico := unSueldo.
	numeroContrato := contrato.
	medioPago := medio. 
! !


!EmpleadoContratado methodsFor: 'calculos'!
calcularRetenciones
	^ 50. 
! !

!EmpleadoContratado methodsFor: 'calculos'!
calcularSueldoBruto
	^ sueldoBasico. 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmpleadoContratado class' category: 'TP-02'!
EmpleadoContratado class
	instanceVariableNames: ''!

!EmpleadoContratado class methodsFor: 'instance creation'!
crearEmpleadoConNacimiento: unaFecha nombre: unNombre direccion: unaDireccion estadoCivil: unEstadoCivil sueldoBasico: unSueldo numeroContrato: contrato medioPago: medio
	^ self new initializeConNacimiento: unaFecha nombre: unNombre direccion: unaDireccion estadoCivil: unEstadoCivil sueldoBasico: unSueldo numeroContrato: contrato medioPago: medio; yourself. 
! !


!classDefinition: #EmpleadoPermanente category: 'TP-02'!
Empleado subclass: #EmpleadoPermanente
	instanceVariableNames: 'cantidadHijos antiguedad'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TP-02'!

!EmpleadoPermanente methodsFor: 'initialization'!
initializeConNacimiento: unaFecha nombre: unNombre direccion: unaDireccion estadoCivil: unEstadoCivil sueldoBasico: unSueldo cantidadHijos: hijos antiguedad: anios
	nombre := unNombre.
	direccion := unaDireccion.
	estadoCivil := unEstadoCivil.
	fechaNacimiento := unaFecha.
	sueldoBasico := unSueldo.
	cantidadHijos := hijos.
	antiguedad := anios. 
! !


!EmpleadoPermanente methodsFor: 'calculos'!
calcularRetenciones
	| sueldoBruto obraSocial jubilacion |
	sueldoBruto := self calcularSueldoBruto.
	obraSocial := (sueldoBruto * 0.10) + (cantidadHijos * 20).
	jubilacion := sueldoBruto * 0.15.
	^ obraSocial + jubilacion. 
! !

!EmpleadoPermanente methodsFor: 'calculos'!
calcularSueldoBruto
	^ sueldoBasico + (cantidadHijos * 150) + (estadoCivil = 'Casado' ifTrue: [100] ifFalse: [0]) + (antiguedad * 50). 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmpleadoPermanente class' category: 'TP-02'!
EmpleadoPermanente class
	instanceVariableNames: ''!

!EmpleadoPermanente class methodsFor: 'instance creation'!
crearEmpleadoConNacimiento: unaFecha nombre: unNombre direccion: unaDireccion estadoCivil: unEstadoCivil sueldoBasico: unSueldo cantidadHijos: hijos antiguedad: anios
	^ self new initializeConNacimiento: unaFecha nombre: unNombre direccion: unaDireccion estadoCivil: unEstadoCivil sueldoBasico: unSueldo cantidadHijos: hijos antiguedad: anios; yourself. 
! !


!classDefinition: #EmpleadoTemporario category: 'TP-02'!
Empleado subclass: #EmpleadoTemporario
	instanceVariableNames: 'fechaFinDesignacion horasExtras'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TP-02'!

!EmpleadoTemporario methodsFor: 'initialization'!
initializeConNacimiento: unaFecha nombre: unNombre direccion: unaDireccion estadoCivil: unEstadoCivil sueldoBasico: unSueldo fechaFin: unaFechaFin horasExtras: horas
	nombre := unNombre.
	direccion := unaDireccion.
	estadoCivil := unEstadoCivil.
	fechaNacimiento := unaFecha.
	sueldoBasico := unSueldo.
	fechaFinDesignacion := unaFechaFin.
	horasExtras := horas. 
! !


!EmpleadoTemporario methodsFor: 'calculos'!
calcularRetenciones
	| sueldoBruto obraSocial jubilacion extraEdad |
	sueldoBruto := self calcularSueldoBruto.
	extraEdad := (self calcularEdad > 50) ifTrue: [25] ifFalse: [0].
	obraSocial := (sueldoBruto * 0.10) + extraEdad.
	jubilacion := (sueldoBruto * 0.10) + (horasExtras * 5).
	^ obraSocial + jubilacion. 
! !

!EmpleadoTemporario methodsFor: 'calculos'!
calcularSueldoBruto
	^ sueldoBasico + (horasExtras * 40). 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmpleadoTemporario class' category: 'TP-02'!
EmpleadoTemporario class
	instanceVariableNames: ''!

!EmpleadoTemporario class methodsFor: 'instance creation'!
crearEmpleadoConNacimiento: unaFecha nombre: unNombre direccion: unaDireccion estadoCivil: unEstadoCivil sueldoBasico: unSueldo fechaFin: unaFechaFin horasExtras: horas
	^ self new initializeConNacimiento: unaFecha nombre: unNombre direccion: unaDireccion estadoCivil: unEstadoCivil sueldoBasico: unSueldo fechaFin: unaFechaFin horasExtras: horas; yourself. 
! !


!classDefinition: #Empresa category: 'TP-02'!
Object subclass: #Empresa
	instanceVariableNames: 'nombre cuit empleados recibos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TP-02'!

!Empresa methodsFor: 'initialization'!
initialize
	empleados := OrderedCollection new.
	recibos := OrderedCollection new. 
! !


!Empresa methodsFor: 'empleados'!
agregarEmpleado: unEmpleado
	empleados add: unEmpleado. 
! !

!Empresa methodsFor: 'empleados' stamp: 'SIZ 9/5/2025 18:10:22'!
empleados
	
	^empleados! !


!Empresa methodsFor: 'calculos'!
totalRetenciones
	^ empleados sum: [:e | e calcularRetenciones]. 
! !

!Empresa methodsFor: 'calculos'!
totalSueldosBrutos
	^ empleados sum: [:e | e calcularSueldoBruto]. 
! !

!Empresa methodsFor: 'calculos'!
totalSueldosNetos
	^ empleados sum: [:e | e calcularSueldoNeto]. 
! !


!Empresa methodsFor: 'recibos'!
liquidarSueldos
	recibos := empleados collect: [:e | e generarRecibo]. 
! !

!Empresa methodsFor: 'recibos'!
recibos
	^ recibos. 
! !


!classDefinition: #ReciboDeHaberes category: 'TP-02'!
Object subclass: #ReciboDeHaberes
	instanceVariableNames: 'nombre direccion fechaEmision sueldoBruto sueldoNeto concepto'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TP-02'!

!ReciboDeHaberes methodsFor: 'generacion' stamp: 'SIZ 9/5/2025 18:28:01'!
generarPara: unEmpleado
	nombre := unEmpleado nombre.
	direccion := unEmpleado direccion.
	fechaEmision := Date today.
	sueldoBruto := unEmpleado calcularSueldoBruto.
	sueldoNeto := unEmpleado calcularSueldoNeto. 
	
	concepto := 'descripcion'
! !


!ReciboDeHaberes methodsFor: 'datos' stamp: 'SIZ 9/5/2025 18:10:35'!
nombre
	
	^nombre! !
