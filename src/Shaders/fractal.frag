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

uniform int MAX_STEPS = 10; //sent step maximum, scales physical precision, default to 10
uniform float MIN_DIST = 0.2; //sent minimum distance for marching, scales definition, default to .02
uniform bool ITER_COLOR = true; //whether to use color by iteration, else uses orbit coloring, default to iteration coloring
uniform vec3 LIGHT_COLOR_AMBIENT = (1.0,1.0,1.0); //ambient light color, used in lighting, default to white
uniform float LIGHT_STRENGTH_AMBIENT = 1; //ambient light strength, used in lighting, default to full
uniform vec3 LIGHT_COLOR_DIFFUSE = (1.0,1.0,1.0); //diffuse light color, used in lighting, default to white
uniform vec3 LIGHT_DIRECTION_DIFFUSE = (0.285714, -0.428571, 0.857143); //sent light direction, pointing TO the light source, default to normal of (2,-3,6), light going left, back, and sharply down towards fractal

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


/**
  * Calculates phong lighting for the point on the fractal.
  * Thank you, Dr. Dellinger for the notes on this. Glad I saved the powerpoint slides from that lecture.
  *
  *
  * Lambert's cosine law (for ambient): Ia = CaMa, where Ia is intensity of reflected light, Ca is ambient brightness, and Ma is ambient reflectance
  * Diffuse: Id = Cd Md COS(theta), where Id is intensity of diffuse light, Cd is incomming diffuse light intensity, Md is material reflectance, and theta is the angle between the light and surface normal
  *          COS(theta) can be simplified to unit(normal)*unit(Ld), where Ld is the vector TOWARDS the diffuse light source.
  * Combined: simply add together
  *
  * inputs:
  * color: color of the particular point
  * normal: the normal vector from the given point, assumes unit
  * ambientColor: the ambient light to apply to the point
  * ambientStrength: strength of ambient light to apply
  * diffuseColor: color of diffuse light to apply
  * diffuseLightDir: direction pointing TO diffuse light source
  */
vec3 calcLight(vec3 color, vec3 normal, vec3 ambientColor, float ambientStrength, vec3 diffuseColor, vec3 diffuseLightDir){
    vec3 amb = ambientColor*ambientStrength;
    //max the diffuse light to avoid backlighting angles that are occluded
    vec3 diff = diffuseColor*max(dot(normal, diffuseLightDir),0.0);
    return color * (amb + diff);
}


/***************************************************************
 *                          RENDERING                          *
 ***************************************************************/

void main(void)
{
    //TODO: actually ray march and get the magic done
    vec3 col = (1.0,1.0,1.0);
    vec3 norm = (0,0,0);
    col += calcLight(col, norm, LIGHT_COLOR_AMBIENT, LIGHT_STRENGTH_AMBIENT, LIGHT_COLOR_DIFFUSE, LIGHT_DIRECTION_DIFFUSE);
}
