import argparse
import pyopenms as pms
import pprint
import sys
import os.path

def addDataProcessing(features, params):
    dp = features.getDataProcessing()
    p = pms.DataProcessing()
    p.setProcessingActions(set([pms.ProcessingAction.QUANTITATION]))
    sw = p.getSoftware()
    sw.setName(os.path.basename(sys.argv[0]))
    sw.setVersion(pms.VersionInfo.getVersion())
    p.setSoftware(sw)
    p.setCompletionTime(pms.DateTime.now())

    for k, v in params.asDict().items():
        p.setMetaValue("parameter: "+k, pms.DataValue(v))

    dp.append(p)
    features.setDataProcessing(dp)

def run_featurefinder_centroided(input_map, params, seeds, out_path):

    ff = pms.FeatureFinder()
    ff.setLogType(pms.LogType.CMD)

    input_map.updateRanges()

    features = pms.FeatureMap()
    name = pms.FeatureFinderAlgorithmPicked.getProductName()
    ff.run(name, input_map, features, params, seeds)

    features.setUniqueIds()
    addDataProcessing(features, params)

    fh = pms.FeatureXMLFile()
    fh.store(out_path, features)


def main():

    parser = argparse.ArgumentParser(description="FeatureFinderCentroided")
    parser.add_argument("-in",
                        action="store",
                        type=str,
                        dest="in_",
                        metavar="input_file",
                        )

    parser.add_argument("-seeds",
                        action="store",
                        type=str,
                        metavar="seeds_file",
                        )

    parser.add_argument("-out",
                        action="store",
                        type=str,
                        metavar="output_file",
                        )

    parser.add_argument("-ini",
                        action="store",
                        type=str,
                        metavar="ini_file",
                        )

    parser.add_argument("-dict_ini",
                        action="store",
                        type=str,
                        metavar="python_dict_ini_file",
                        )

    parser.add_argument("-write_ini",
                        action="store",
                        type=str,
                        metavar="ini_file",
                        )

    parser.add_argument("-write_dict_ini",
                        action="store",
                        type=str,
                        metavar="python_dict_ini_file",
                        )

    args = parser.parse_args()

    run_mode = args.in_ is not None and args.out is not None\
                and (args.ini is not None or args.dict_ini is not None)
    write_mode = args.write_ini is not None or args.write_dict_ini is not None
    ok = run_mode or write_mode
    if not ok:
        parser.error("either specify -in, -out and -(dict)ini for running "
                     "the peakpicker\nor -write(dict)ini for creating std "
                     "ini file")

    name = pms.FeatureFinderAlgorithmPicked.getProductName()
    defaults = pms.FeatureFinder().getParameters(name)

    if args.write_dict_ini or args.write_ini:
        if args.write_dict_ini:
            with open(args.write_dict_ini, "w") as fp:
                pprint.pprint(defaults.asDict(), stream=fp)
        if args.write_ini:
            defaults.store(args.write_ini)

    else:
        if args.ini:
            param = pms.Param()
            param.load(args.ini)
            defaults.update(param, False, False)
        elif args.dict_ini:
            with open(args.dict_ini, "r") as fp:
                try:
                    dd = eval(fp.read())
                except:
                    raise Exception("could not parse %s" % args.dict_ini)
            defaults.updateFrom(dd)

        seeds = pms.FeatureMap()
        if args.seeds:
            fh = pms.FeatureXMLFile()
            fh.load(args.seeds, seeds)

        fh = pms.MzXMLFile()
        fh.setLogType(pms.LogType.CMD)
        input_map = pms.MSExperiment()
        fh.load(args.in_, input_map)

        run_featurefinder_centroided(input_map, defaults, seeds, args.out)

if __name__ == "__main__":
    main()
