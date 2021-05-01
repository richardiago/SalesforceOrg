import { LightningElement, api } from 'lwc';
import { ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class inputFile extends LightningElement {
    
    @api recordId;

    get acceptedFormats() {
        return ['.pdf', '.png', '.jpg'];
    }

    handleUploadFinished(event) {
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;
        dispatchEvent(
            new ShowToastEvent({
                title: "Upload de arquivo",
                message: "Upload de arquivo feito com sucesso",
                variant: 'success',
            })
        )
    }
}