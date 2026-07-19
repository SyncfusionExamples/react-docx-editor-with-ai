# React DOCX Editor with AI feature Sample

This repository contains an example demonstrating how to securely integrate Azure OpenAI with the Syncfusion<sup style="font-size:70%">&reg;</sup> [React DOCX Editor](https://www.syncfusion.com/docx-editor-sdk/react-docx-editor?utm_source=github&utm_medium=listing&utm_campaign=github-github-documenteditor-examples) (Document Editor) using an ASP.NET Core Web API. It showcases AI-powered document editing features such as content generation, rewriting, grammar correction, translation, summarization, and conversational assistance while ensuring that Azure OpenAI credentials remain securely on the server side.

Unlike the default client-side implementation, this sample routes all AI requests through an ASP.NET Core Web API. The React application is responsible for building AI prompts and user interactions, while the server securely communicates with Azure OpenAI and returns the generated content to the editor. This architecture improves security, simplifies maintenance, and enables future AI provider integrations without exposing sensitive credentials to the browser.

---

## How to Run the Sample

Follow the steps below to configure and run the React DOCX Editor sample with the ASP.NET Core Web API and Azure OpenAI integration.

### Prerequisites

Before running the sample, ensure the following software is installed:

- .NET 10 SDK
- Node.js (LTS version recommended)
- npm
- A valid Syncfusion® license key
- An Azure OpenAI resource with a deployed chat model (for example, GPT-4o or GPT-4.1)

### Register the Syncfusion License

Open the following file:

```text
Client-side/src/index.tsx
```

Register your Syncfusion license key.

```ts
import { registerLicense } from '@syncfusion/ej2-base';

registerLicense("YOUR LICENSE KEY");
```

### Configure Azure OpenAI

Open the following file:

```text
Server-side/src/appsettings.json
```

Update the `AzureOpenAI` section with your Azure OpenAI resource information.

```json
"AzureOpenAI": {
  "Endpoint": "<YOUR_AZURE_OPENAI_ENDPOINT>",
  "ApiKey": "<YOUR_AZURE_OPENAI_API_KEY>",
  "DeploymentName": "<YOUR_DEPLOYMENT_NAME>"
}
```

> **Note:** The deployment name must match the chat model deployment configured in your Azure OpenAI resource.

### Install Dependencies

#### React Application

```bash
cd cd .\Client-side\
npm install
```

#### ASP.NET Core Web API

```bash
cd .\Server-side\src
dotnet restore
```

### Run the Web API

Open a terminal and run:

```bash
cd .\Server-side\src
dotnet run
```

Once the application starts successfully, note the Web API URL displayed in the terminal.

### Update the Web API Base URL

After starting the ASP.NET Core Web API, note the URL displayed in the terminal. For example:

```text
Now listening on: http://localhost:62870
```

Open the following file:

```text
Client-side/src/ai-models.ts
```

Update the `API_BASE` constant to match the running Web API URL.

```ts
const API_BASE = "http://localhost:62870/api/DocumentEditor";
```

> **Note:** Replace `62870` with the actual port assigned to your Web API.

### Run the React Application

Open a new terminal and run:

```bash
cd .\Client-side\
npm start
```

The React application will start and open automatically in your default browser.

### Verify the Sample

1. Open or create a document in the DOCX Editor.
2. Select any text in the document.
3. Choose an AI option such as **Grammar**, **Summarize**, **Rephrase**, or **Translate**.
4. The request is sent to the ASP.NET Core Web API, which securely communicates with Azure OpenAI and returns the generated content to the editor.

### Notes

- Azure OpenAI credentials are configured only in the ASP.NET Core Web API.
- The React application communicates with the Web API and does not expose Azure OpenAI credentials to the browser.
- Ensure the React application is configured with the correct Web API URL before running the sample.
---

## Demo

<p align="center">
  <img
    src="asset/React-DOCX-Editor-AI-Assistance-Demo.gif"
    alt="React DOCX Editor AI Assistance Demo"
    width="1000" />
</p>

---

# Web API Endpoints

The ASP.NET Core Web API exposes a set of REST endpoints that enable the Syncfusion Document Editor to perform server-side document processing operations such as document import/export, spell checking, document protection, mail merge, PDF conversion, and AI-assisted content generation. The following table lists the available endpoints included in this sample.


| Endpoint                                                     | Method | Description                                                                                                                                                                                                                      |
| ------------------------------------------------------------ | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `/api/DocumentEditor/Process`                                | `POST` | Sends the user prompt to the configured Azure OpenAI deployment and returns the generated HTML/text response. Used for AI-powered document generation, rewriting, summarization, translation, and other prompt-based operations. |
| `/api/DocumentEditor/SpellCheck`                             | `POST` | Performs spell checking on the supplied text and returns spelling suggestions.                                                                                                                                                   |
| `/api/DocumentEditor/SpellCheckByPage`                       | `POST` | Performs page-wise spell checking for large documents to improve performance.                                                                                                                                                    |
| `/api/DocumentEditor/SystemClipboard`                        | `POST` | Imports HTML or RTF content from the system clipboard into the Document Editor.                                                                                                                                                  |
| `/api/DocumentEditor/Import`                                 | `POST` | Imports supported document formats and converts them into the SFDT format used by the Document Editor.                                                                                                                           |
| `/api/DocumentEditor/RestrictEditing`                        | `POST` | Applies document protection or restrict editing settings.                                                                                                                                                                        |
| `/api/DocumentEditor/EnforceProtection`                      | `POST` | Enables document protection using the specified protection type and password.                                                                                                                                                    |
| `/api/DocumentEditor/UnprotectDocument`                      | `POST` | Removes document protection using the provided password.                                                                                                                                                                         |
| `/api/DocumentEditor/WordToPdf`                              | `POST` | Converts a Word document into PDF format.                                                                                                                                                                                        |
| `/api/DocumentEditor/MailMerge`                              | `POST` | Performs mail merge using the supplied template and data source.                                                                                                                                                                 |
| `/api/DocumentEditor/ImportFormFields`                       | `POST` | Imports form field values into a document.                                                                                                                                                                                       |
| `/api/DocumentEditor/ExportFormFields`                       | `POST` | Exports all form field values from a document.                                                                                                                                                                                   |
| `/api/DocumentEditor/ExecuteCustomAction` *(if implemented)* | `POST` | Executes custom server-side document processing logic.                                                                                                                                                                           |


---

# Project Workflow

The sample follows a client-server architecture where all AI requests are securely processed through an ASP.NET Core Web API.

```text
+----------------------------+
| React DOCX Editor          |
| (Client Application)       |
+-------------+--------------+
              |
              | AI Request
              | (Prompt + Options)
              v
+----------------------------+
| ASP.NET Core Web API       |
| DocumentEditorController   |
+-------------+--------------+
              |
              | Creates Chat Request
              v
+----------------------------+
| AzureOpenAIProvider        |
+-------------+--------------+
              |
              | Azure OpenAI SDK
              v
+----------------------------+
| Azure OpenAI               |
| GPT Deployment             |
+-------------+--------------+
              |
              | Generated HTML
              v
+----------------------------+
| ASP.NET Core Web API       |
+-------------+--------------+
              |
              | JSON Response
              v
+----------------------------+
| React DOCX Editor          |
| Inserts generated content  |
| into the document          |
+----------------------------+
```

# Resources

- **Product page:**   [Syncfusion® React DOCX Editor](https://www.syncfusion.com/docx-editor-sdk/react-docx-editor?utm_source=github&utm_medium=listing&utm_campaign=github-github-documenteditor-examples) 

- **Documentation:**   [Syncfusion® React DOCX Editor - Documentation](https://help.syncfusion.com/document-processing/word/word-processor/react/overview?utm_source=github&utm_medium=listing&utm_campaign=github-github-documenteditor-examples) 

- **Online demo:**   [Syncfusion® React DOCX Editor - Online demo](https://document.syncfusion.com/demos/docx-editor/react/#/tailwind3/document-editor/default?utm_source=github&utm_medium=listing&utm_campaign=github-github-documenteditor-examples) 

# Support and feedback 

For any other queries, reach our [Syncfusion® support team](https://support.syncfusion.com/?utm_source=github&utm_medium=listing&utm_campaign=github-github-documenteditor-examples) or post the queries through the [community forums](https://www.syncfusion.com/forums?utm_source=github&utm_medium=listing&utm_campaign=github-github-documenteditor-examples). 

Request new feature through [Syncfusion® feedback portal](https://www.syncfusion.com/feedback?utm_source=github&utm_medium=listing&utm_campaign=github-github-documenteditor-examples). 

# License

This is a commercial product and requires a paid license for possession or use Syncfusion's licensed software, including this component, is subject to the terms and conditions of [Syncfusion's EULA](https://www.syncfusion.com/license/studio/34.1.29/syncfusion_essential_studio_eula.pdf?utm_source=github&utm_medium=listing&utm_campaign=github-github-documenteditor-examples). You can purchase a licnense [here](https://www.syncfusion.com/sales/products?utm_source=github&utm_medium=listing&utm_campaign=github-github-documenteditor-examples) or start a free 30\-day trial [here](https://www.syncfusion.com/account/manage-trials/start-trials?utm_source=github&utm_medium=listing&utm_campaign=github-github-documenteditor-examples). 