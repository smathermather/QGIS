/** \ingroup analysis
 * The QGis class provides vector geometry analysis functions
 */

class QgsGeometryAnalyzer
{
%TypeHeaderCode
#include <qgsgeometryanalyzer.h>
%End

  public:

    /**Simplify vector layer using (a modified) Douglas-Peucker algorithm
     and write it to a new shape file
      @param layer input vector layer
      @param shapefileName path to the output shp
      @param tolerance (level of simplification)
      @param onlySelectedFeatures if true, only selected features are considered, else all the features
      @param p progress dialog (or 0 if no progress dialog is to be shown)
      @note: added in version 1.4*/
    bool simplify( QgsVectorLayer* layer, const QString& shapefileName, double tolerance,
                   bool onlySelectedFeatures = false, QProgressDialog* p = 0 );

    /**Calculate the true centroids, or 'center of mass' for a vector layer and
       write it to a new shape file
      @param layer input vector layer
      @param shapefileName path to the output shp
      @param onlySelectedFeatures if true, only selected features are considered, else all the features
      @param p progress dialog (or 0 if no progress dialog is to be shown)
      @note: added in version 1.4*/
    bool centroids( QgsVectorLayer* layer, const QString& shapefileName,
                    bool onlySelectedFeatures = false, QProgressDialog* p = 0 );

    /**Create a polygon based on the extent of all (selected) features and write it to a new shape file
      @param layer input vector layer
      @param shapefileName path to the output shp
      @param onlySelectedFeatures if true, only selected features are considered, else all the features
      @param p progress dialog (or 0 if no progress dialog is to be shown)
      @note: added in version 1.4*/
    bool extent( QgsVectorLayer* layer, const QString& shapefileName, bool onlySelectedFeatures = false, QProgressDialog* p = 0 );

    /**Create buffers for a vector layer and write it to a new shape file
      @param layer input vector layer
      @param shapefileName path to the output shp
      @param bufferDistance distance for buffering (if no buffer field is specified)
      @param onlySelectedFeatures if true, only selected features are considered, else all the features
      @param dissolve if true, merge all the buffers to a big multipolygon
      @param bufferDistanceField index of the attribute field that contains the buffer distance (or -1 if all features have the same buffer distance)
      @param p progress dialog (or 0 if no progress dialog is to be shown)
      @note: added in version 1.3*/
    bool buffer( QgsVectorLayer* layer, const QString& shapefileName, double bufferDistance,
                 bool onlySelectedFeatures = false, bool dissolve = false, int bufferDistanceField = -1, QProgressDialog* p = 0 );

    /**Create convex hull(s) of a vector layer and write it to a new shape file
      @param layer input vector layer
      @param shapefileName path to the output shp
      @param onlySelectedFeatures if true, only selected features are considered, else all the features
      @param uniqueIdField index of the attribute field that contains the unique convex hull id (or -1 if
      all features have the same buffer distance)
      @param p progress dialog (or 0 if no progress dialog is to be shown)
      @note: added in version 1.4*/
    bool convexHull( QgsVectorLayer* layer, const QString& shapefileName, bool onlySelectedFeatures = false,
                     int uniqueIdField = -1, QProgressDialog* p = 0 );

    /**Dissolve a vector layer and write it to a new shape file
      @param layer input vector layer
      @param shapefileName path to the output shp
      @param onlySelectedFeatures if true, only selected features are considered, else all the features
      @param uniqueIdField index of the attribute field that contains the unique id to dissolve on (or -1 if
      all features should be dissolved together)
      @param p progress dialog (or 0 if no progress dialog is to be shown)
      @note: added in version 1.4*/
    bool dissolve( QgsVectorLayer* layer, const QString& shapefileName, bool onlySelectedFeatures = false,
                   int uniqueIdField = -1, QProgressDialog* p = 0 );

    /**Creates an event layer (multipoint or multiline) by locating features from a (non-spatial) event table along the features of a line layer.
        Note that currently (until QgsGeometry supports m-values) the z-coordinate of the line layer is used for linear referencing
      @param lineLayer layer with the line geometry
      @param eventLayer layer with features and location field
      @param lineField join index in line layer
      @param eventField join index in event layer
      @param outputLayer name of output file (can be empty if a memory layer is used)
      @param outputFormat name of output format (can be empty if a memory provider is used to store the results)
      @param unlocatedFeatureIds out: ids of event features where linear referencing was not successful
      @param locationField1 attribute index of location field in event layer
      @param locationField2 attribute index of location end field (or -1 for point layer)
      @param offsetField attribute index for offset field. Negative offset value = offset to left side, positive value = offset to right side
      @param offsetScale factor to scale offset
      @param forceSingleGeometry force layer to single point/line type. Feature attributes are copied in case of multiple matches
      @param memoryProvider memory provider to write output to (can be 0 if output is written to a file)
      @param p progress dialog or 0 if no progress dialog should be shown
    */
    bool eventLayer( QgsVectorLayer* lineLayer, QgsVectorLayer* eventLayer, int lineField, int eventField, QSet<qint64> &unlocatedFeatureIds /Out/, const QString& outputLayer,
                     const QString& outputFormat, int locationField1, int locationField2 = -1, int offsetField = -1, double offsetScale = 1.0,
                     bool forceSingleGeometry = false, QgsVectorDataProvider* memoryProvider = 0, QProgressDialog* p = 0 );

    /**Returns linear reference geometry as a multiline (or 0 if no match). Currently, the z-coordinates are considered to be the measures (no support for m-values in QGIS)*/
    QgsGeometry* locateBetweenMeasures( double fromMeasure, double toMeasure, QgsGeometry* lineGeom );
    /**Returns linear reference geometry. Unlike the PostGIS function, this method always returns multipoint or 0 if no match (not geometry collection).
      Currently, the z-coordinates are considered to be the measures (no support for m-values in QGIS)*/
    QgsGeometry* locateAlongMeasure( double measure, QgsGeometry* lineGeom );

};
