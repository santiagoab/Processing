float Stiffness = 5.0;  //K
float BobMass = 0.5; //massa
int StateSize = 3;
float[] InitState = new float[StateSize]; //Actualizan los valores
float[] State = new float[StateSize];
int StateCurrentTime = 0;
int StatePositionX = 1;
int StateVelocityX = 2;
int WindowWidthHeight = 300;

float WorldSize = 3.0;
float PixelsPerMeter;
float OriginPixelsX;
float OriginPixelsY;

void setup()
{
// Crear estad inicial de posicion i velocidad (x0 i v0).
InitState[StateCurrentTime] = 0.0;
InitState[StatePositionX] = 0.65;
InitState[StateVelocityX] = 0.0;

// Convierte el estdo incial en el estado actual.
for ( int i = 0; i < StateSize; ++i )   
{
State[i] = InitState[i];
}

// Color general del sketch.
colorMode( RGB, 1.0 );
// Color y ancho de la "cuerda" y los bordes.
stroke( 0.0 );
strokeWeight( 0.01 );

// Tamaño de la ventana.
size( WindowWidthHeight, WindowWidthHeight );
PixelsPerMeter = (( float )WindowWidthHeight ) / WorldSize;
OriginPixelsX = 0.5 * ( float )WindowWidthHeight;
OriginPixelsY = 0.5 * ( float )WindowWidthHeight;
}



void DrawState()
{
// Final del muelle.
float SpringEndX = PixelsPerMeter * State[StatePositionX];
// Posición correcta del final del muelle.

float sqrtKoverM = sqrt( Stiffness / BobMass );  //Raíz cuadrada de K/M
float x0 = InitState[StatePositionX];
float v0 = InitState[StateVelocityX];
float t = State[StateCurrentTime];
float CorrectPositionX = ( x0 * cos( sqrtKoverM * t ) ) +
( ( v0 / sqrtKoverM ) * sin( sqrtKoverM + t ) );       //Ecuación general el movimiento del massa-muelle.
// Dibuja la posición correcta.
float CorrectEndX = PixelsPerMeter * CorrectPositionX;

// Dibuja el "muelle".
strokeWeight( 1.0 );
line( 0.0, 0.0, SpringEndX, 0.0 );

// Dibuja el soporte del muelle.
fill( 0.0 );
ellipse( 0.0, 0.0, PixelsPerMeter * 0.03, PixelsPerMeter * 0.03 );
// Dibuja la massa al final del muelle.
fill( 0.25, 0.75, 0.0 );
ellipse( SpringEndX, 0.0, PixelsPerMeter * 0.2, PixelsPerMeter * 0.2 );
// Dibuja el peso con el movimiento correcto.
fill( 0.0, 0.0, 0.5 );
ellipse( CorrectEndX, -PixelsPerMeter * 0.25, PixelsPerMeter * 0.1, PixelsPerMeter * 0.1 );
}

// Función del paso del tiempo.
void TimeStep( float i_dt )
{
// Calculo de la acceleración a partir de la posición actual.
float A = ( -Stiffness / BobMass ) * State[StatePositionX];
// Actualización de la posición con la velocidad actual.
State[StatePositionX] += i_dt * State[StateVelocityX];
// Actualización de la velocidad según la acceleración.
State[StateVelocityX] += i_dt * A;
// Actualización del timepo.
State[StateCurrentTime] += i_dt;
}



void draw()
{
// Paso del timepo.
TimeStep( 1.0/24.0 );
// Color de fondo.
background( 0.75 );
// Colocar el sketch en el orígen.
translate( OriginPixelsX, OriginPixelsY );
// Dibujo del sketch.
DrawState();
}


