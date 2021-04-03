#version 120
/***************************************************************
 *                             DOCS                            *
 *
 * Implements fractal rendering via a raymarching technique.
 * The following articles proved immensely helpful in
 * understanding the mathematics and rendering techniques used
 * for fractals.
 *
 * http://blog.hvidtfeldts.net/index.php/2011/06/distance-estimated-3d-fractals-part-i/
 * https://www.iquilezles.org/www/index.htm
 *
 * As was this YouTuber, who got me interested in fractals in
 * the first place. He also linked the above articles, where
 * in turn he first learned.
 *
 * https://www.youtube.com/watch?v=svLzmFuSBhk
 *
 * I stand on the shoulders of giants.
 ***************************************************************/

//TODO: distance estimator
//TODO: soft shadows
//TODO: glow
//TODO: color
//TODO: reflections?

/***************************************************************
 *                          PARAMETERS                         *
 ***************************************************************/

uniform sampler2D qt_Texture0;
varying vec4 qt_TexCoord0;
uniform vec3 LIGHT_DIRECTION = (-0.285714, 0.428571, -0.857143); //sent light direction, default to normal of (-2,3,-6), light going left, back, and sharply down
uniform int MAX_STEPS = 10; //sent step maximum, scales physical precision, default to 10
uniform float MIN_DIST = 0.2; //sent minimum distance for marching, scales definition, default to .02
uniform bool ITER_COLOR = true; //whether to use color by iteration, else uses orbit coloring, default to iteration coloring

/***************************************************************
 *                           STRUCTS                           *
 ***************************************************************/

/**
  * A struct to keep track of raymarching results
  *
  * distance: final distance from the fractal
  * steps: how many steps performed
  * stepPerc: percentage of total alloted steps taken
  * totalDistance: total distance the ray marched, assigned by start of func call
  */
struct march_result {
    float distance;
    int steps;
    float stepPerc;
    float totalDistance;
};

/***************************************************************
 *                       HELPER FUNCTIONS                      *
 ***************************************************************/

/**
  * Estimates the distance to the fractal
  *
  * inputs:
  * pos: current ray position
  */
float DE(vec3 pos){
    return 0.0;
}


/**
  * Marches a ray by a given step count to max, determining the grayscale value by step count.
  * Relies on DE, which is a distance estimator function.
  *
  * inputs:
  * from: starting point of the ray
  * direction: direction to march the ray
  **/
march_result march(vec3 from, vec3 direction) {
    march_result res; //resulting struct
    float totalDistance = 0.0; //total distance traveled (used for GLOW)
    float distance = MIN_DIST; //distance to fractal (used for FOG)
    int steps; //total steps taken, used for COLOR
    vec3 point = from; //current point for iteration

    //loop through steps in ray
    for (steps=0; steps < MAX_STEPS; steps++){
        distance = DE(point);
        totalDistance += distance;
        if (distance < MIN_DIST) break;
        //calculate new step point
        point = from + totalDistance * direction;
    }

    //assign resulting variables
    res.stepPerc = 1.0-float(steps)/float(MAX_STEPS);
    res.steps = steps;
    res.totalDistance = totalDistance;
    res.distance = distance;
    return res;
}

/**
  * Returns the normal, calculated via the distance estimator
  * This is done by probing in x, y, and z directions slightly.
  * This will return an estimated distance in each direction from the fractal, which can be used to generate a normal that we can normalize.
  *
  * inputs:
  * pos: current position
  * xDir, yDir, zDir: x y and z directions
  */
vec3 getNormal(vec3 pos, vec3 xDir, vec3 yDir, vec3 zDir){
    return normalize(vec3(DE(pos+xDir)-DE(pos-xDir),
                                   DE(pos+yDir)-DE(pos-yDir),
                                   DE(pos+zDir)-DE(pos-zDir)));
}


/***************************************************************
 *                          RENDERING                          *
 ***************************************************************/

void main(void)
{
    gl_FragColor = texture2D(qt_Texture0, qt_TexCoord0.st);
}
