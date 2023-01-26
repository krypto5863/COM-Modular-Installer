using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CMIHelper
{
	public class Core
	{
		public int limit { get; set; }
		public int remaining { get; set; }
		public int reset { get; set; }
		public int used { get; set; }
		public string resource { get; set; }

	}
	public class Graphql
	{
		public int limit { get; set; }
		public int remaining { get; set; }
		public int reset { get; set; }
		public int used { get; set; }
		public string resource { get; set; }

	}
	public class Integration_manifest
	{
		public int limit { get; set; }
		public int remaining { get; set; }
		public int reset { get; set; }
		public int used { get; set; }
		public string resource { get; set; }

	}
	public class Search
	{
		public int limit { get; set; }
		public int remaining { get; set; }
		public int reset { get; set; }
		public int used { get; set; }
		public string resource { get; set; }

	}
	public class resources
	{
		public Core core { get; set; }
		public Graphql graphql { get; set; }
		public Integration_manifest integration_manifest { get; set; }
		public Search search { get; set; }

	}
	public class Rate
	{
		public int limit { get; set; }
		public int remaining { get; set; }
		public int reset { get; set; }
		public int used { get; set; }
		public string resource { get; set; }

	}
	public class APIRateLimitResponse
	{
		public resources resources { get; set; }
		public Rate rate { get; set; }

	}
}
