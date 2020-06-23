let () = Wrap_utils.init ();;
let __wrap_namespace = Py.import "sklearn.base"

let get_py name = Py.Module.get __wrap_namespace name
module BaseEstimator = struct
type tag = [`BaseEstimator]
type t = [`BaseEstimator | `Object] Obj.t
let of_pyobject x = ((Obj.of_pyobject x) : t)
let to_pyobject x = Obj.to_pyobject x
let create () =
   Py.Module.get_function_with_keywords __wrap_namespace "BaseEstimator"
     [||]
     []
     |> of_pyobject
let get_params ?deep self =
   Py.Module.get_function_with_keywords (to_pyobject self) "get_params"
     [||]
     (Wrap_utils.keyword_args [("deep", Wrap_utils.Option.map deep Py.Bool.of_bool)])
     |> Dict.of_pyobject
let set_params ?params self =
   Py.Module.get_function_with_keywords (to_pyobject self) "set_params"
     [||]
     (match params with None -> [] | Some x -> x)
     |> of_pyobject
let to_string self = Py.Object.to_string (to_pyobject self)
let show self = to_string self
let pp formatter self = Format.fprintf formatter "%s" (show self)

end
module BiclusterMixin = struct
type tag = [`BiclusterMixin]
type t = [`BiclusterMixin | `Object] Obj.t
let of_pyobject x = ((Obj.of_pyobject x) : t)
let to_pyobject x = Obj.to_pyobject x
let create () =
   Py.Module.get_function_with_keywords __wrap_namespace "BiclusterMixin"
     [||]
     []
     |> of_pyobject
let get_indices ~i self =
   Py.Module.get_function_with_keywords (to_pyobject self) "get_indices"
     [||]
     (Wrap_utils.keyword_args [("i", Some(i |> Py.Int.of_int))])
     |> (fun x -> ((Wrap_utils.id (Py.Tuple.get x 0)), (Wrap_utils.id (Py.Tuple.get x 1))))
let get_shape ~i self =
   Py.Module.get_function_with_keywords (to_pyobject self) "get_shape"
     [||]
     (Wrap_utils.keyword_args [("i", Some(i |> Py.Int.of_int))])
     |> (fun x -> ((Py.Int.to_int (Py.Tuple.get x 0)), (Py.Int.to_int (Py.Tuple.get x 1))))
let get_submatrix ~i ~data self =
   Py.Module.get_function_with_keywords (to_pyobject self) "get_submatrix"
     [||]
     (Wrap_utils.keyword_args [("i", Some(i |> Py.Int.of_int)); ("data", Some(data |> Np.Obj.to_pyobject))])
     |> (fun py -> (Np.Obj.of_pyobject py : [>`ArrayLike] Np.Obj.t))
let to_string self = Py.Object.to_string (to_pyobject self)
let show self = to_string self
let pp formatter self = Format.fprintf formatter "%s" (show self)

end
module ClassifierMixin = struct
type tag = [`ClassifierMixin]
type t = [`ClassifierMixin | `Object] Obj.t
let of_pyobject x = ((Obj.of_pyobject x) : t)
let to_pyobject x = Obj.to_pyobject x
let create () =
   Py.Module.get_function_with_keywords __wrap_namespace "ClassifierMixin"
     [||]
     []
     |> of_pyobject
let score ?sample_weight ~x ~y self =
   Py.Module.get_function_with_keywords (to_pyobject self) "score"
     [||]
     (Wrap_utils.keyword_args [("sample_weight", Wrap_utils.Option.map sample_weight Np.Obj.to_pyobject); ("X", Some(x |> Np.Obj.to_pyobject)); ("y", Some(y |> Np.Obj.to_pyobject))])
     |> Py.Float.to_float
let to_string self = Py.Object.to_string (to_pyobject self)
let show self = to_string self
let pp formatter self = Format.fprintf formatter "%s" (show self)

end
module ClusterMixin = struct
type tag = [`ClusterMixin]
type t = [`ClusterMixin | `Object] Obj.t
let of_pyobject x = ((Obj.of_pyobject x) : t)
let to_pyobject x = Obj.to_pyobject x
let create () =
   Py.Module.get_function_with_keywords __wrap_namespace "ClusterMixin"
     [||]
     []
     |> of_pyobject
let fit_predict ?y ~x self =
   Py.Module.get_function_with_keywords (to_pyobject self) "fit_predict"
     [||]
     (Wrap_utils.keyword_args [("y", y); ("X", Some(x |> Np.Obj.to_pyobject))])
     |> (fun py -> (Np.Obj.of_pyobject py : [>`ArrayLike] Np.Obj.t))
let to_string self = Py.Object.to_string (to_pyobject self)
let show self = to_string self
let pp formatter self = Format.fprintf formatter "%s" (show self)

end
module DensityMixin = struct
type tag = [`DensityMixin]
type t = [`DensityMixin | `Object] Obj.t
let of_pyobject x = ((Obj.of_pyobject x) : t)
let to_pyobject x = Obj.to_pyobject x
let create () =
   Py.Module.get_function_with_keywords __wrap_namespace "DensityMixin"
     [||]
     []
     |> of_pyobject
let score ?y ~x self =
   Py.Module.get_function_with_keywords (to_pyobject self) "score"
     [||]
     (Wrap_utils.keyword_args [("y", y); ("X", Some(x |> Np.Obj.to_pyobject))])
     |> Py.Float.to_float
let to_string self = Py.Object.to_string (to_pyobject self)
let show self = to_string self
let pp formatter self = Format.fprintf formatter "%s" (show self)

end
module MetaEstimatorMixin = struct
type tag = [`MetaEstimatorMixin]
type t = [`MetaEstimatorMixin | `Object] Obj.t
let of_pyobject x = ((Obj.of_pyobject x) : t)
let to_pyobject x = Obj.to_pyobject x
let create () =
   Py.Module.get_function_with_keywords __wrap_namespace "MetaEstimatorMixin"
     [||]
     []
     |> of_pyobject
let to_string self = Py.Object.to_string (to_pyobject self)
let show self = to_string self
let pp formatter self = Format.fprintf formatter "%s" (show self)

end
module MultiOutputMixin = struct
type tag = [`MultiOutputMixin]
type t = [`MultiOutputMixin | `Object] Obj.t
let of_pyobject x = ((Obj.of_pyobject x) : t)
let to_pyobject x = Obj.to_pyobject x
let create () =
   Py.Module.get_function_with_keywords __wrap_namespace "MultiOutputMixin"
     [||]
     []
     |> of_pyobject
let to_string self = Py.Object.to_string (to_pyobject self)
let show self = to_string self
let pp formatter self = Format.fprintf formatter "%s" (show self)

end
module OutlierMixin = struct
type tag = [`OutlierMixin]
type t = [`Object | `OutlierMixin] Obj.t
let of_pyobject x = ((Obj.of_pyobject x) : t)
let to_pyobject x = Obj.to_pyobject x
let create () =
   Py.Module.get_function_with_keywords __wrap_namespace "OutlierMixin"
     [||]
     []
     |> of_pyobject
let fit_predict ?y ~x self =
   Py.Module.get_function_with_keywords (to_pyobject self) "fit_predict"
     [||]
     (Wrap_utils.keyword_args [("y", y); ("X", Some(x |> Np.Obj.to_pyobject))])
     |> (fun py -> (Np.Obj.of_pyobject py : [>`ArrayLike] Np.Obj.t))
let to_string self = Py.Object.to_string (to_pyobject self)
let show self = to_string self
let pp formatter self = Format.fprintf formatter "%s" (show self)

end
module RegressorMixin = struct
type tag = [`RegressorMixin]
type t = [`Object | `RegressorMixin] Obj.t
let of_pyobject x = ((Obj.of_pyobject x) : t)
let to_pyobject x = Obj.to_pyobject x
let create () =
   Py.Module.get_function_with_keywords __wrap_namespace "RegressorMixin"
     [||]
     []
     |> of_pyobject
let score ?sample_weight ~x ~y self =
   Py.Module.get_function_with_keywords (to_pyobject self) "score"
     [||]
     (Wrap_utils.keyword_args [("sample_weight", Wrap_utils.Option.map sample_weight Np.Obj.to_pyobject); ("X", Some(x |> Np.Obj.to_pyobject)); ("y", Some(y |> Np.Obj.to_pyobject))])
     |> Py.Float.to_float
let to_string self = Py.Object.to_string (to_pyobject self)
let show self = to_string self
let pp formatter self = Format.fprintf formatter "%s" (show self)

end
module TransformerMixin = struct
type tag = [`TransformerMixin]
type t = [`Object | `TransformerMixin] Obj.t
let of_pyobject x = ((Obj.of_pyobject x) : t)
let to_pyobject x = Obj.to_pyobject x
let create () =
   Py.Module.get_function_with_keywords __wrap_namespace "TransformerMixin"
     [||]
     []
     |> of_pyobject
let fit_transform ?y ?fit_params ~x self =
   Py.Module.get_function_with_keywords (to_pyobject self) "fit_transform"
     [||]
     (List.rev_append (Wrap_utils.keyword_args [("y", Wrap_utils.Option.map y Np.Obj.to_pyobject); ("X", Some(x |> Np.Obj.to_pyobject))]) (match fit_params with None -> [] | Some x -> x))
     |> (fun py -> (Np.Obj.of_pyobject py : [>`ArrayLike] Np.Obj.t))
let to_string self = Py.Object.to_string (to_pyobject self)
let show self = to_string self
let pp formatter self = Format.fprintf formatter "%s" (show self)

end
module Defaultdict = struct
type tag = [`Defaultdict]
type t = [`Defaultdict | `Object] Obj.t
let of_pyobject x = ((Obj.of_pyobject x) : t)
let to_pyobject x = Obj.to_pyobject x
let get_item ~y self =
   Py.Module.get_function_with_keywords (to_pyobject self) "__getitem__"
     [||]
     (Wrap_utils.keyword_args [("y", Some(y ))])

let iter self =
   Py.Module.get_function_with_keywords (to_pyobject self) "__iter__"
     [||]
     []
     |> (fun py -> Py.Iter.to_seq py |> Seq.map Dict.of_pyobject)
let __setitem__ ~key ~value self =
   Py.Module.get_function_with_keywords (to_pyobject self) "__setitem__"
     (Array.of_list @@ List.concat [[key ];[value ]])
     []

let fromkeys ?value ~iterable self =
   Py.Module.get_function_with_keywords (to_pyobject self) "fromkeys"
     (Array.of_list @@ List.concat [(match value with None -> [] | Some x -> [x ]);[iterable ]])
     []

let get ?default ~key self =
   Py.Module.get_function_with_keywords (to_pyobject self) "get"
     (Array.of_list @@ List.concat [(match default with None -> [] | Some x -> [x ]);[key ]])
     []

let pop ?d ~k self =
   Py.Module.get_function_with_keywords (to_pyobject self) "pop"
     [||]
     (Wrap_utils.keyword_args [("d", d); ("k", Some(k ))])

let popitem self =
   Py.Module.get_function_with_keywords (to_pyobject self) "popitem"
     [||]
     []

let setdefault ?default ~key self =
   Py.Module.get_function_with_keywords (to_pyobject self) "setdefault"
     (Array.of_list @@ List.concat [(match default with None -> [] | Some x -> [x ]);[key ]])
     []

let update ?e ?f self =
   Py.Module.get_function_with_keywords (to_pyobject self) "update"
     [||]
     (List.rev_append (Wrap_utils.keyword_args [("E", e)]) (match f with None -> [] | Some x -> x))

let to_string self = Py.Object.to_string (to_pyobject self)
let show self = to_string self
let pp formatter self = Format.fprintf formatter "%s" (show self)

end
let clone ?safe ~estimator () =
   Py.Module.get_function_with_keywords __wrap_namespace "clone"
     [||]
     (Wrap_utils.keyword_args [("safe", Wrap_utils.Option.map safe Py.Bool.of_bool); ("estimator", Some(estimator |> Np.Obj.to_pyobject))])

let is_classifier estimator =
   Py.Module.get_function_with_keywords __wrap_namespace "is_classifier"
     [||]
     (Wrap_utils.keyword_args [("estimator", Some(estimator |> Np.Obj.to_pyobject))])
     |> Py.Bool.to_bool
let is_outlier_detector estimator =
   Py.Module.get_function_with_keywords __wrap_namespace "is_outlier_detector"
     [||]
     (Wrap_utils.keyword_args [("estimator", Some(estimator |> Np.Obj.to_pyobject))])
     |> Py.Bool.to_bool
let is_regressor estimator =
   Py.Module.get_function_with_keywords __wrap_namespace "is_regressor"
     [||]
     (Wrap_utils.keyword_args [("estimator", Some(estimator |> Np.Obj.to_pyobject))])
     |> Py.Bool.to_bool
